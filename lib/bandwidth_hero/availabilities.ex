defmodule BandwidthHero.Availabilities do
  @moduledoc """
  The Availabilities context.
  """

  import Ecto.Query, warn: false
  alias BandwidthHero.Repo

  alias BandwidthHero.Availabilities.Availability

  def list_availabilities do
    Repo.all(Availability)
  end

  def get_availability!(id), do: Repo.get!(Availability, id)

  def create_availability(attrs \\ %{}) do
    %Availability{}
    |> Availability.changeset(attrs)
    |> Repo.insert()
  end

  def update_availability(%Availability{} = availability, attrs) do
    availability
    |> Availability.changeset(attrs)
    |> Repo.update()
  end

  def delete_availability(%Availability{} = availability) do
    Repo.delete(availability)
  end

  def change_availability(%Availability{} = availability, attrs \\ %{}) do
    Availability.changeset(availability, attrs)
  end
end
