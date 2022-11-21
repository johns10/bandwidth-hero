defmodule BandwidthHero.ContractorOpportunities do
  @moduledoc """
  The ContractorOpportunities context.
  """

  import Ecto.Query, warn: false
  alias BandwidthHero.Repo

  alias BandwidthHero.ContractorOpportunities.ContractorOpportunity

  def list_contractor_opportunities(opts \\ []) do
    filters = Keyword.get(opts, :filters)
    preloads = Keyword.get(opts, :preloads)

    ContractorOpportunity
    |> maybe_filter_by_contractor_id(filters[:contractor_id])
    |> maybe_preload_opportunity(preloads[:opportunity])
    |> Repo.all()
  end

  def get_contractor_opportunity!(id, opts \\ []) do
    filters = Keyword.get(opts, :filters)
    preloads = Keyword.get(opts, :preloads)

    ContractorOpportunity
    |> maybe_filter_by_contractor_id(filters[:contractor_id])
    |> maybe_preload_opportunity(preloads[:opportunity])
    |> Repo.get!(id)
  end

  defp maybe_filter_by_contractor_id(query, nil), do: query

  defp maybe_filter_by_contractor_id(query, contractor_id) do
    where(query, [co], co.contractor_id == ^contractor_id)
  end

  defp maybe_preload_opportunity(query, nil), do: query

  defp maybe_preload_opportunity(query, _) do
    query
    |> join(:left, [co], o in assoc(co, :opportunity), as: :opportunity)
    |> preload([co, opportunity: o], opportunity: o)
  end

  def create_contractor_opportunity(attrs \\ %{}) do
    %ContractorOpportunity{}
    |> ContractorOpportunity.changeset(attrs)
    |> Repo.insert()
  end

  def update_contractor_opportunity(%ContractorOpportunity{} = contractor_opportunity, attrs) do
    contractor_opportunity
    |> ContractorOpportunity.changeset(attrs)
    |> Repo.update()
  end

  def delete_contractor_opportunity(%ContractorOpportunity{} = contractor_opportunity) do
    Repo.delete(contractor_opportunity)
  end

  def change_contractor_opportunity(
        %ContractorOpportunity{} = contractor_opportunity,
        attrs \\ %{}
      ) do
    ContractorOpportunity.changeset(contractor_opportunity, attrs)
  end
end
