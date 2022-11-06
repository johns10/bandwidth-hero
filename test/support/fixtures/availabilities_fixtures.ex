defmodule BandwidthHero.AvailabilitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BandwidthHero.Availabilities` context.
  """

  @doc """
  Generate a availability.
  """
  def availability_fixture(attrs \\ %{}) do
    {:ok, availability} =
      attrs
      |> Enum.into(%{
        available_from: ~D[2022-11-04],
        available_to: ~D[2023-11-04],
        hours: 10
      })
      |> BandwidthHero.Availabilities.create_availability()

    availability
  end
end
