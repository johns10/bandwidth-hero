defmodule BandwidthHero.OpportunitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BandwidthHero.Opportunities` context.
  """

  @doc """
  Generate a opportunity.
  """
  def opportunity_fixture(attrs \\ %{}) do
    {:ok, opportunity} =
      attrs
      |> Enum.into(%{
        contract_type: [:corp_to_corp],
        description: "some description",
        from_date: ~D[2022-11-10],
        hours_per_week: 40,
        laptop: [:use_my_own],
        name: "some name",
        rate: "120.5",
        to_date: ~D[2022-11-10],
        travel: [:"100%"]
      })
      |> BandwidthHero.Opportunities.create_opportunity()

    opportunity
  end
end
