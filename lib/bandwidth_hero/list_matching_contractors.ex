defmodule BandwidthHero.ListMatchingContractors do
  import Ecto.Query, warn: false
  alias BandwidthHero.Repo
  alias BandwidthHero.Opportunities.Opportunity
  alias BandwidthHero.Contractors.Contractor
  alias BandwidthHero.ListMatchingContractors.AvailabilityScore
  alias BandwidthHero.ListMatchingContractors.SkillScore

  def execute(%Opportunity{} = opportunity) do
    execute_query(opportunity)
    |> calculate_score(opportunity)
  end

  def execute_query(%Opportunity{} = opportunity) do
    query(opportunity)
    |> Repo.all()
  end

  def query(%{opportunity_erp_tags: opportunity_erp_tags, from_date: from, to_date: to}) do
    opportunity_erp_tags_ids = Enum.map(opportunity_erp_tags, & &1.erp_tag_id)

    Contractor
    |> distinct(true)
    |> join(:left, [c], a in assoc(c, :availabilities), as: :av)
    |> join(:left, [c], ce in assoc(c, :contractor_erp_tags), as: :cet)
    |> join(:left, [cet: cet], et in assoc(cet, :erp_tag), as: :et)
    |> join(:left, [c], co in assoc(c, :contractor_opportunities), as: :co)
    |> where([cet: cet], cet.erp_tag_id in ^opportunity_erp_tags_ids)
    |> where([av: av], not (av.available_to <= ^from and av.available_from < ^from))
    |> where([av: av], not (av.available_to > ^to and av.available_from >= ^to))
    |> where([av: av], av.hours > 0)
    |> preload([av: av, cet: e, et: t, co: co],
      availabilities: av,
      contractor_opportunities: co,
      contractor_erp_tags: {e, erp_tag: t}
    )
  end

  def calculate_score(contractors, opportunity) do
    availability_metrics = AvailabilityScore.calculate_opportunity_metric(opportunity)
    skill_metrics = SkillScore.calculate_opportunity_metric(opportunity)

    contractors
    |> Enum.map(&%{contractor: &1, metrics: availability_metrics, skill_metrics: skill_metrics})
    |> Enum.map(&AvailabilityScore.calculate/1)
    |> Enum.map(&SkillScore.calculate/1)
  end
end
