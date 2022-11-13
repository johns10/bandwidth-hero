defmodule BandwidthHero.ListMatchingContractors.AvailabilityScore do
  import Ecto.Query, warn: false
  alias BandwidthHero.Opportunities.Opportunity
  alias BandwidthHero.Availabilities.Availability

  def calculate(%{contractor: contractor, metrics: metrics} = state) do
    %{availabilities: availabilities} = contractor

    score =
      availabilities
      |> Enum.map(&truncate_dates(&1, metrics))
      |> Enum.map(&calculate_availability_metrics/1)
      |> Enum.reduce(%{}, &aggregate_date_metrics/2)
      |> score_date_metrics(metrics)

    Map.put(state, :availability_score, score)
  end

  def truncate_dates(
        %Availability{available_from: available_from, available_to: available_to} = availability,
        %{start_date: start_date, end_date: end_date}
      ) do
    availability
    |> Map.put(:available_from, latest_date(available_from, start_date))
    |> Map.put(:available_to, earliest_date(available_to, end_date))
  end

  def calculate_availability_metrics(%Availability{
        available_from: start_date,
        available_to: end_date,
        hours: hours_per_week
      }),
      do:
        calculate_date_metrics(%{
          start_date: start_date,
          end_date: end_date,
          hours_per_week: hours_per_week
        })

  def aggregate_date_metrics(metrics, acc) do
    days = Map.get(acc, :days, 0)
    total_hours = Map.get(acc, :total_hours, 0)
    start_date = Map.get(acc, :start_date, metrics.start_date)
    end_date = Map.get(acc, :end_date, metrics.end_date)

    acc
    |> Map.put(:days, days + metrics.days)
    |> Map.put(:start_date, earliest_date(start_date, metrics.start_date))
    |> Map.put(:end_date, latest_date(end_date, metrics.end_date))
    |> Map.put(:total_hours, total_hours + metrics.hours_per_day * metrics.days)
  end

  def score_date_metrics(aggregate, baseline) do
    aggregate.total_hours / baseline.total_hours
  end

  def calculate_opportunity_metric(%Opportunity{} = opportunity),
    do:
      calculate_date_metrics(%{
        start_date: opportunity.from_date,
        end_date: opportunity.to_date,
        hours_per_week: opportunity.hours_per_week
      })

  def calculate_date_metrics(%{
        start_date: start_date,
        end_date: end_date,
        hours_per_week: hours_per_week
      }) do
    hours_per_day = hours_per_week / 7
    days = Date.diff(end_date, start_date)

    %{
      start_date: start_date,
      end_date: end_date,
      hours_per_day: hours_per_day,
      days: days,
      total_hours: hours_per_day * days
    }
  end

  def earliest_date(date1, date2) do
    case Date.compare(date1, date2) do
      :lt -> date1
      :eq -> date1
      :gt -> date2
    end
  end

  def latest_date(date1, date2) do
    case Date.compare(date1, date2) do
      :lt -> date2
      :eq -> date2
      :gt -> date1
    end
  end
end
