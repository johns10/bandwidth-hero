defmodule BandwidthHero.ContractorOpportunitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BandwidthHero.ContractorOpportunities` context.
  """

  @doc """
  Generate a contractor_opportunity.
  """
  def contractor_opportunity_fixture(attrs \\ %{}) do
    {:ok, contractor_opportunity} =
      attrs
      |> Enum.into(%{
        message: "some message",
        subject: "some subject"
      })
      |> BandwidthHero.ContractorOpportunities.create_contractor_opportunity()

    contractor_opportunity
  end
end
