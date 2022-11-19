defmodule BandwidthHero.ContractorOpportunities do
  @moduledoc """
  The ContractorOpportunities context.
  """

  import Ecto.Query, warn: false
  alias BandwidthHero.Repo

  alias BandwidthHero.ContractorOpportunities.ContractorOpportunity

  @doc """
  Returns the list of contractor_opportunities.

  ## Examples

      iex> list_contractor_opportunities()
      [%ContractorOpportunity{}, ...]

  """
  def list_contractor_opportunities do
    Repo.all(ContractorOpportunity)
  end

  @doc """
  Gets a single contractor_opportunity.

  Raises `Ecto.NoResultsError` if the Contractor opportunity does not exist.

  ## Examples

      iex> get_contractor_opportunity!(123)
      %ContractorOpportunity{}

      iex> get_contractor_opportunity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contractor_opportunity!(id), do: Repo.get!(ContractorOpportunity, id)

  @doc """
  Creates a contractor_opportunity.

  ## Examples

      iex> create_contractor_opportunity(%{field: value})
      {:ok, %ContractorOpportunity{}}

      iex> create_contractor_opportunity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contractor_opportunity(attrs \\ %{}) do
    %ContractorOpportunity{}
    |> ContractorOpportunity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a contractor_opportunity.

  ## Examples

      iex> update_contractor_opportunity(contractor_opportunity, %{field: new_value})
      {:ok, %ContractorOpportunity{}}

      iex> update_contractor_opportunity(contractor_opportunity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contractor_opportunity(%ContractorOpportunity{} = contractor_opportunity, attrs) do
    contractor_opportunity
    |> ContractorOpportunity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a contractor_opportunity.

  ## Examples

      iex> delete_contractor_opportunity(contractor_opportunity)
      {:ok, %ContractorOpportunity{}}

      iex> delete_contractor_opportunity(contractor_opportunity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contractor_opportunity(%ContractorOpportunity{} = contractor_opportunity) do
    Repo.delete(contractor_opportunity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contractor_opportunity changes.

  ## Examples

      iex> change_contractor_opportunity(contractor_opportunity)
      %Ecto.Changeset{data: %ContractorOpportunity{}}

  """
  def change_contractor_opportunity(%ContractorOpportunity{} = contractor_opportunity, attrs \\ %{}) do
    ContractorOpportunity.changeset(contractor_opportunity, attrs)
  end
end
