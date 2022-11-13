defmodule BandwidthHero.ListMatchingContractors.SkillScore do
  import Ecto.Query, warn: false
  alias BandwidthHero.Opportunities.Opportunity
  alias BandwidthHero.Contractors.Contractor

  def calculate(%{contractor: contractor, skill_metrics: metrics} = state) do
    skill_score =
      contractor
      |> calculate_contractor_metric()
      |> score_skill_metric(metrics)

    Map.put(state, :skill_score, skill_score)
  end

  def calculate_opportunity_metric(%Opportunity{opportunity_erp_tags: tags}),
    do: calculate_skill_metric(tags)

  def calculate_contractor_metric(%Contractor{contractor_erp_tags: tags}),
    do: calculate_skill_metric(tags)

  def calculate_skill_metric(items) do
    items
    |> Enum.reduce(%{total_projects: 0, total_years: 0}, fn opportunity_erp_tag, acc ->
      acc
      |> Map.put(:total_projects, acc.total_projects + opportunity_erp_tag.projects)
      |> Map.put(:total_years, acc.total_years + opportunity_erp_tag.years)
    end)
  end

  def score_skill_metric(contractor, baseline) do
    (contractor.total_projects + contractor.total_years) /
      (baseline.total_projects + baseline.total_years)
  end
end
