defmodule BandwidthHero.TagsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BandwidthHero.Tags` context.
  """

  @doc """
  Generate a erp_tag.
  """
  def erp_tag_fixture(attrs \\ %{}) do
    {:ok, erp_tag} =
      attrs
      |> Enum.into(%{
        label: "some label"
      })
      |> BandwidthHero.Tags.create_erp_tag()

    erp_tag
  end
end
