defmodule BandwidthHero.SourcerUsers do
  @moduledoc """
  The SourcerUsers context.
  """

  import Ecto.Query, warn: false
  alias BandwidthHero.Repo

  alias BandwidthHero.SourcerUsers.SourcerUser

  def list_sourcer_users do
    Repo.all(SourcerUser)
  end

  def get_sourcer_user!(id), do: Repo.get!(SourcerUser, id)

  def create_sourcer_user(attrs \\ %{}) do
    %SourcerUser{}
    |> SourcerUser.changeset(attrs)
    |> Repo.insert()
  end

  def update_sourcer_user(%SourcerUser{} = sourcer_user, attrs) do
    sourcer_user
    |> SourcerUser.changeset(attrs)
    |> Repo.update()
  end

  def delete_sourcer_user(%SourcerUser{} = sourcer_user) do
    Repo.delete(sourcer_user)
  end

  def change_sourcer_user(%SourcerUser{} = sourcer_user, attrs \\ %{}) do
    SourcerUser.changeset(sourcer_user, attrs)
  end
end
