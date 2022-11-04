defmodule BandwidthHero.Tags do
  @moduledoc """
  The Tags context.
  """

  import Ecto.Query, warn: false
  alias BandwidthHero.Repo

  alias BandwidthHero.Tags.ErpTag

  def list_erp_tags(opts \\ []) do
    filters = Keyword.get(opts, :filters)
    ErpTag
    |> maybe_filter_by_type(filters[:type])
    |> Repo.all()
  end

  defp maybe_filter_by_type(query, nil), do: query
  defp maybe_filter_by_type(query, type) do
    where(query, [c], c.type == ^type)
  end

  def get_erp_tag!(id), do: Repo.get!(ErpTag, id)

  def create_erp_tag(attrs \\ %{}) do
    %ErpTag{}
    |> ErpTag.changeset(attrs)
    |> Repo.insert()
  end

  def update_erp_tag(%ErpTag{} = erp_tag, attrs) do
    erp_tag
    |> ErpTag.changeset(attrs)
    |> Repo.update()
  end

  def delete_erp_tag(%ErpTag{} = erp_tag) do
    Repo.delete(erp_tag)
  end

  def change_erp_tag(%ErpTag{} = erp_tag, attrs \\ %{}) do
    ErpTag.changeset(erp_tag, attrs)
  end
end
