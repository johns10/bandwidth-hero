defmodule BandwidthHero.Sourcers do
  @moduledoc """
  The Sourcers context.
  """

  import Ecto.Query, warn: false
  alias BandwidthHero.Repo

  alias BandwidthHero.Sourcers.Sourcer

  def list_sourcers(opts \\ []) do
    preloads = Keyword.get(opts, :preloads, [])

    Sourcer
    |> maybe_preload_opportunities(preloads[:opportunities])
    |> Repo.all()
  end

  def get_sourcer!(id, opts \\ []) do
    preloads = Keyword.get(opts, :preloads, [])

    Sourcer
    |> maybe_preload_opportunities(preloads[:opportunities])
    |> Repo.get!(id)
  end

  def get_sourcer(id, opts \\ []) do
    preloads = Keyword.get(opts, :preloads, [])

    Sourcer
    |> maybe_preload_opportunities(preloads[:opportunities])
    |> Repo.get(id)
  end

  defp maybe_preload_opportunities(query, nil), do: query

  defp maybe_preload_opportunities(query, _) do
    query
    |> join(:left, [s], o in assoc(s, :opportunities), as: :opportunities)
    |> preload([s, opportunities: o], opportunities: o)
  end

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
