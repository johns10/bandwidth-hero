defmodule BandwidthHero.Sourcers do
  @moduledoc """
  The Sourcers context.
  """

  import Ecto.Query, warn: false
  alias BandwidthHero.Repo

  alias BandwidthHero.Sourcers.Sourcer

  def list_sourcers do
    Repo.all(Sourcer)
  end

  def get_sourcer!(id), do: Repo.get!(Sourcer, id)
  def get_sourcer(id), do: Repo.get(Sourcer, id)

  def create_sourcer(attrs \\ %{}) do
    %Sourcer{}
    |> Sourcer.changeset(attrs)
    |> Repo.insert()
  end

  def update_sourcer(%Sourcer{} = sourcer, attrs) do
    sourcer
    |> Sourcer.changeset(attrs)
    |> Repo.update()
  end

  def delete_sourcer(%Sourcer{} = sourcer) do
    Repo.delete(sourcer)
  end

  def change_sourcer(%Sourcer{} = sourcer, attrs \\ %{}) do
    Sourcer.changeset(sourcer, attrs)
  end
end
