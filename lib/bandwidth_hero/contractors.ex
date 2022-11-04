defmodule BandwidthHero.Contractors do
  @moduledoc """
  The Contractors context.
  """

  import Ecto.Query, warn: false
  alias BandwidthHero.Repo

  alias BandwidthHero.Contractors.Contractor

  def list_contractors(opts \\ []) do
    preloads = Keyword.get(opts, :preloads, [])
    Contractor
    |> maybe_preload_contractor_erp_tags(preloads[:contractor_erp_tags])
    |> Repo.all()
  end

  def get_contractor!(id, opts \\ []) do
    preloads = Keyword.get(opts, :preloads, [])
    Contractor
    |> maybe_preload_contractor_erp_tags(preloads[:contractor_erp_tags])
    |> Repo.get!(id)
  end

  defp maybe_preload_contractor_erp_tags(query, nil), do: query
  defp maybe_preload_contractor_erp_tags(query, _) do
    query
    |> join(:left, [c], e in assoc(c, :contractor_erp_tags))
    |> join(:left, [c, e], t in assoc(e, :erp_tag))
    |> preload([c, e, t], [contractor_erp_tags: {e, erp_tag: t}])
  end

  def create_contractor(attrs \\ %{}) do
    %Contractor{}
    |> Contractor.changeset(attrs)
    |> Repo.insert()
  end

  def update_contractor(%Contractor{} = contractor, attrs) do
    contractor
    |> Contractor.changeset(attrs)
    |> Repo.update()
  end

  def delete_contractor(%Contractor{} = contractor) do
    Repo.delete(contractor)
  end

  def change_contractor(%Contractor{} = contractor, attrs \\ %{}) do
    Contractor.changeset(contractor, attrs)
  end
end
