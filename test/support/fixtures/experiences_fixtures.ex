defmodule BandwidthHero.ExperiencesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BandwidthHero.Experiences` context.
  """

  @doc """
  Generate a experience.
  """
  def experience_fixture(attrs \\ %{}) do
    {:ok, experience} =
      attrs
      |> Enum.into(%{
        description: "some description",
        from: ~D[2022-10-29],
        label: "some label",
        to: ~D[2022-10-29]
      })
      |> BandwidthHero.Experiences.create_experience()

    experience
  end
end
