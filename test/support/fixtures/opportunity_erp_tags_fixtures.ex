defmodule BandwidthHero.OpportunityErpTagsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BandwidthHero.OpportunityErpTags` context.
  """

  @doc """
  Generate a opportunity_erp_tag.
  """
  def opportunity_erp_tag_fixture(attrs \\ %{}) do
    {:ok, opportunity_erp_tag} =
      attrs
      |> Enum.into(%{
        projects: 42,
        years: 42
      })
      |> BandwidthHero.OpportunityErpTags.create_opportunity_erp_tag()

    opportunity_erp_tag
  end
end
