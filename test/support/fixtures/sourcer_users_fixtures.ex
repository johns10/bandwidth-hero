defmodule BandwidthHero.SourcerUsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BandwidthHero.SourcerUsers` context.
  """

  @doc """
  Generate a sourcer_user.
  """
  def sourcer_user_fixture(attrs \\ %{}) do
    {:ok, sourcer_user} =
      attrs
      |> Enum.into(%{
        position: "some position"
      })
      |> BandwidthHero.SourcerUsers.create_sourcer_user()

    sourcer_user
  end
end
