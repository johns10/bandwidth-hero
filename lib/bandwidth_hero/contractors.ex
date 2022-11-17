defmodule BandwidthHero.Contractors do
  @moduledoc """
  The Contractors context.
  """

  import Ecto.Query, warn: false
  alias BandwidthHero.Repo

  alias BandwidthHero.Contractors.Contractor

  @behaviour Bodyguard.Policy

  def authorize(:update_contractor, %{id: id}, %{user_id: id}), do: :ok
  def authorize(:update_contractor, _user, _contractor), do: :error

  def list_contractors(opts \\ []) do
    preloads = Keyword.get(opts, :preloads, [])

    Contractor
    |> maybe_preload_contractor_erp_tags(preloads[:contractor_erp_tags])
    |> maybe_preload_availabilities(preloads[:availabilities])
    |> Repo.all()
  end

  def get_contractor!(id, opts \\ []) do
    preloads = Keyword.get(opts, :preloads, [])

    Contractor
    |> maybe_preload_contractor_erp_tags(preloads[:contractor_erp_tags])
    |> maybe_preload_availabilities(preloads[:availabilities])
    |> Repo.get!(id)
  end

  def get_contractor_by_user_id(user_id, opts \\ []) do
    preloads = Keyword.get(opts, :preloads, [])

    Contractor
    |> where([c], c.user_id == ^user_id)
    |> maybe_preload_contractor_erp_tags(preloads[:contractor_erp_tags])
    |> maybe_preload_availabilities(preloads[:availabilities])
    |> Repo.one()
  end

  defp maybe_preload_availabilities(query, nil), do: query

  defp maybe_preload_availabilities(query, _) do
    query
    |> join(:left, [c], a in assoc(c, :availabilities), as: :availabilities)
    |> preload([c, availabilities: a], availabilities: a)
  end

  defp maybe_preload_contractor_erp_tags(query, nil), do: query

  defp maybe_preload_contractor_erp_tags(query, _) do
    query
    |> join(:left, [c], e in assoc(c, :contractor_erp_tags), as: :cet)
    |> join(:left, [c, cet: e], t in assoc(e, :erp_tag), as: :et)
    |> preload([c, cet: e, et: t], contractor_erp_tags: {e, erp_tag: t})
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
