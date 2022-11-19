defmodule BandwidthHero.IntegrationFixtures do
  import BandwidthHero.ContractorFixtures
  import BandwidthHero.AvailabilitiesFixtures
  import BandwidthHero.ContractorErpTagsFixtures
  import BandwidthHero.OpportunitiesFixtures
  import BandwidthHero.OpportunityErpTagsFixtures

  alias BandwidthHero.Tags
  alias BandwidthHero.Contractors

  def full_contractor(availabilities, skills) do
    contractor = contractor_fixture()

    availabilities
    |> Enum.map(fn [from, to, hours] ->
      availability_fixture(%{
        available_from: from,
        available_to: to,
        hours: hours,
        contractor_id: contractor.id
      })
    end)

    skills
    |> Enum.map(fn [module_name, projects, years] ->
      [erp_tag] = Tags.list_erp_tags(filters: [label: module_name])

      contractor_erp_tag_fixture(%{
        projects: projects,
        years: years,
        contractor_id: contractor.id,
        erp_tag_id: erp_tag.id
      })
    end)

    Contractors.get_contractor!(contractor.id,
      preloads: [availabilities: true, contractor_erp_tags: true, contractor_opportunities: true]
    )
  end

  def full_opportunity(attrs, skill_requirements) do
    opportunity = opportunity_fixture(attrs)

    skill_requirements
    |> Enum.map(fn [module_name, projects, years] ->
      [erp_tag] = Tags.list_erp_tags(filters: [label: module_name])

      opportunity_erp_tag_fixture(%{
        projects: projects,
        years: years,
        opportunity_id: opportunity.id,
        erp_tag_id: erp_tag.id
      })
    end)

    opportunity
  end
end
