defmodule BandwidthHero.Experiences.Experience do
  use Ecto.Schema
  import Ecto.Changeset

  schema "experiences" do
    field :description, :string
    field :from, :date
    field :label, :string
    field :to, :date

    timestamps()
  end

  @doc false
  def changeset(experience, attrs) do
    experience
    |> cast(attrs, [:label, :description, :from, :to])
    |> validate_required([:label, :description, :from, :to])
  end
end
