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
    |> maybe_filter_by_parent_id(filters[:parent_id])
    |> maybe_filter_by_label(filters[:label])
    |> Repo.all()
  end

  def get_erp_tag!(id), do: Repo.get!(ErpTag, id)

  defp maybe_filter_by_parent_id(query, nil), do: query

  defp maybe_filter_by_parent_id(query, parent_id) do
    where(query, [c], c.parent_id == ^parent_id)
  end

  defp maybe_filter_by_label(query, nil), do: query

  defp maybe_filter_by_label(query, label) do
    where(query, [c], c.label == ^label)
  end

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
