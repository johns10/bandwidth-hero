defmodule BandwidthHero.ContractorErpTagsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BandwidthHero.ContractorErpTags` context.
  """

  @doc """
  Generate a contractor_erp_tag.
  """

  def contractor_erp_tag_fixture(attrs \\ %{}) do
    {:ok, contractor_erp_tag} =
      attrs
      |> Enum.into(%{
        projects: 42,
        years: 42,
        contractor_id: Map.get(attrs, :contractor_id, nil),
        erp_tag_id: Map.get(attrs, :erp_tag_id, nil)
      })
      |> BandwidthHero.ContractorErpTags.create_contractor_erp_tag()

    contractor_erp_tag
  end
end
