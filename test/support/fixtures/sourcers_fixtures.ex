defmodule BandwidthHero.SourcersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BandwidthHero.Sourcers` context.
  """

  @doc """
  Generate a sourcer.
  """
  def sourcer_fixture(attrs \\ %{}) do
    {:ok, sourcer} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        type: :end_customer,
        website: "some website"
      })
      |> BandwidthHero.Sourcers.create_sourcer()

    sourcer
  end
end
