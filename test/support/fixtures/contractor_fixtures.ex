defmodule BandwidthHero.ContractorFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BandwidthHero.Contractors` context.
  """

  @doc """
  Generate a contractor.
  """
  def contractor_fixture(attrs \\ %{}) do
    {:ok, contractor} =
      attrs
      |> Enum.into(%{
        contract_type: [:corp_to_corp],
        international_travel: :yes,
        laptop: [:use_my_own],
        name: "some name",
        title: "some title",
        travel: [:"100%"]
      })
      |> BandwidthHero.Contractors.create_contractor()

    contractor
  end
end
