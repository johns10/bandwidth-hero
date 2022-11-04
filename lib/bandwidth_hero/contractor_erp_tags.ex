defmodule BandwidthHero.ContractorErpTags do
  @moduledoc """
  The ContractorErpTags context.
  """

  import Ecto.Query, warn: false
  alias BandwidthHero.Repo

  alias BandwidthHero.ContractorErpTags.ContractorErpTag

  def list_contractor_erp_tag(opts \\ []) do
    filters = Keyword.get(opts, :filters)
    preloads = Keyword.get(opts, :preloads)
    ContractorErpTag
    |> maybe_filter_by_contractor_id(filters[:contractor_id])
    |> maybe_preload_erp_tag(preloads[:erp_tag])
    |> Repo.all()
  end

  defp maybe_preload_erp_tag(query, nil), do: query
  defp maybe_preload_erp_tag(query, _) do
    query
    |> preload([t], [:erp_tag])
  end

  defp maybe_filter_by_contractor_id(query, nil), do: query
  defp maybe_filter_by_contractor_id(query, contractor_id) do
    where(query, [t], t.contractor_id == ^contractor_id)
  end

  def get_contractor_erp_tag!(id, opts \\ []) do
    preloads = Keyword.get(opts, :preloads)
    ContractorErpTag
    |> maybe_preload_erp_tag(preloads[:erp_tag])
    |> Repo.get!(id)
  end

  def create_contractor_erp_tag(attrs \\ %{}) do
    %ContractorErpTag{}
    |> ContractorErpTag.changeset(attrs)
    |> Repo.insert()
  end

  def update_contractor_erp_tag(%ContractorErpTag{} = contractor_erp_tag, attrs) do
    contractor_erp_tag
    |> ContractorErpTag.changeset(attrs)
    |> Repo.update()
  end

  def delete_contractor_erp_tag(%ContractorErpTag{} = contractor_erp_tag) do
    Repo.delete(contractor_erp_tag)
  end

  def change_contractor_erp_tag(%ContractorErpTag{} = contractor_erp_tag, attrs \\ %{}) do
    ContractorErpTag.changeset(contractor_erp_tag, attrs)
  end
end
