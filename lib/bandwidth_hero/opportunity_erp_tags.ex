defmodule BandwidthHero.OpportunityErpTags do
  @moduledoc """
  The OpportunityErpTags context.
  """

  import Ecto.Query, warn: false
  alias BandwidthHero.Repo

  alias BandwidthHero.OpportunityErpTags.OpportunityErpTag

  @doc """
  Returns the list of opportunity_erp_tags.

  ## Examples

      iex> list_opportunity_erp_tags()
      [%OpportunityErpTag{}, ...]

  """
  def list_opportunity_erp_tags do
    Repo.all(OpportunityErpTag)
  end

  @doc """
  Gets a single opportunity_erp_tag.

  Raises `Ecto.NoResultsError` if the Opportunity erp tag does not exist.

  ## Examples

      iex> get_opportunity_erp_tag!(123)
      %OpportunityErpTag{}

      iex> get_opportunity_erp_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_opportunity_erp_tag!(id), do: Repo.get!(OpportunityErpTag, id)

  @doc """
  Creates a opportunity_erp_tag.

  ## Examples

      iex> create_opportunity_erp_tag(%{field: value})
      {:ok, %OpportunityErpTag{}}

      iex> create_opportunity_erp_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_opportunity_erp_tag(attrs \\ %{}) do
    %OpportunityErpTag{}
    |> OpportunityErpTag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a opportunity_erp_tag.

  ## Examples

      iex> update_opportunity_erp_tag(opportunity_erp_tag, %{field: new_value})
      {:ok, %OpportunityErpTag{}}

      iex> update_opportunity_erp_tag(opportunity_erp_tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_opportunity_erp_tag(%OpportunityErpTag{} = opportunity_erp_tag, attrs) do
    opportunity_erp_tag
    |> OpportunityErpTag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a opportunity_erp_tag.

  ## Examples

      iex> delete_opportunity_erp_tag(opportunity_erp_tag)
      {:ok, %OpportunityErpTag{}}

      iex> delete_opportunity_erp_tag(opportunity_erp_tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_opportunity_erp_tag(%OpportunityErpTag{} = opportunity_erp_tag) do
    Repo.delete(opportunity_erp_tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking opportunity_erp_tag changes.

  ## Examples

      iex> change_opportunity_erp_tag(opportunity_erp_tag)
      %Ecto.Changeset{data: %OpportunityErpTag{}}

  """
  def change_opportunity_erp_tag(%OpportunityErpTag{} = opportunity_erp_tag, attrs \\ %{}) do
    OpportunityErpTag.changeset(opportunity_erp_tag, attrs)
  end
end
