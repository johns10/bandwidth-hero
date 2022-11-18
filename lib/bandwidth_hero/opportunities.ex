defmodule BandwidthHero.Opportunities do
  @moduledoc """
  The Opportunities context.
  """

  import Ecto.Query, warn: false
  alias BandwidthHero.Repo

  alias BandwidthHero.Opportunities.Opportunity

  @behaviour Bodyguard.Policy

  def authorize(:update_opportunity, %{sourcer_users: sourcer_users}, %{sourcer_id: sourcer_id})
      when is_list(sourcer_users) do
    if sourcer_id in Enum.map(sourcer_users, & &1.sourcer_id), do: :ok, else: :error
  end

  def authorize(:update_opportunity, user, %{sourcer_id: sourcer_id}) do
    %{sourcer_users: sourcer_users} = Repo.preload(user, :sourcer_users)
    if sourcer_id in Enum.map(sourcer_users, & &1.sourcer_id), do: :ok, else: :error
  end

  def list_opportunities(opts \\ []) do
    preloads = Keyword.get(opts, :preloads, [])

    Opportunity
    |> maybe_preload_opportunity_erp_tags(preloads[:opportunity_erp_tags])
    |> Repo.all()
  end

  def get_opportunity!(id, opts \\ []) do
    preloads = Keyword.get(opts, :preloads, [])

    Opportunity
    |> maybe_preload_opportunity_erp_tags(preloads[:opportunity_erp_tags])
    |> Repo.get!(id)
  end

  def get_opportunity(id, opts \\ []) do
    preloads = Keyword.get(opts, :preloads, [])

    Opportunity
    |> maybe_preload_opportunity_erp_tags(preloads[:opportunity_erp_tags])
    |> Repo.get(id)
  end

  defp maybe_preload_opportunity_erp_tags(query, nil), do: query

  defp maybe_preload_opportunity_erp_tags(query, _) do
    query
    |> join(:left, [o], e in assoc(o, :opportunity_erp_tags), as: :opportunity_erp_tags)
    |> join(:left, [opportunity_erp_tags: e], t in assoc(e, :erp_tag), as: :erp_tag)
    |> preload([c, opportunity_erp_tags: e, erp_tag: t], opportunity_erp_tags: {e, erp_tag: t})
  end

  def create_opportunity(attrs \\ %{}) do
    %Opportunity{}
    |> Opportunity.changeset(attrs)
    |> Repo.insert()
  end

  def update_opportunity(%Opportunity{} = opportunity, attrs) do
    opportunity
    |> Opportunity.changeset(attrs)
    |> Repo.update()
  end

  def delete_opportunity(%Opportunity{} = opportunity) do
    Repo.delete(opportunity)
  end

  def change_opportunity(%Opportunity{} = opportunity, attrs \\ %{}) do
    Opportunity.changeset(opportunity, attrs)
  end
end
