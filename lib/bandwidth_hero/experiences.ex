defmodule BandwidthHero.Experiences do
  @moduledoc """
  The Experiences context.
  """

  import Ecto.Query, warn: false
  alias BandwidthHero.Repo

  alias BandwidthHero.Experiences.Experience

  def list_experiences do
    Repo.all(Experience)
  end

  def get_experience!(id), do: Repo.get!(Experience, id)

  def create_experience(attrs \\ %{}) do
    %Experience{}
    |> Experience.changeset(attrs)
    |> Repo.insert()
  end

  def update_experience(%Experience{} = experience, attrs) do
    experience
    |> Experience.changeset(attrs)
    |> Repo.update()
  end

  def delete_experience(%Experience{} = experience) do
    Repo.delete(experience)
  end

  def change_experience(%Experience{} = experience, attrs \\ %{}) do
    Experience.changeset(experience, attrs)
  end
end
