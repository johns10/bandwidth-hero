defmodule BandwidthHero.Sourcers.Sourcer do
  use Ecto.Schema
  import Ecto.Changeset
  alias BandwidthHero.SourcerUsers.SourcerUser
  alias BandwidthHero.Opportunities.Opportunity

  schema "sourcers" do
    field :description, :string
    field :name, :string
    field :type, Ecto.Enum, values: [:end_customer, :recruiter, :consulting_firm]
    field :website, :string

    has_many :sourcer_users, SourcerUser
    has_many :users, through: [:sourcer_users, :user]
    has_many :opportunities, Opportunity

    timestamps()
  end

  @doc false
  def changeset(sourcer, attrs) do
    sourcer
    |> cast(attrs, [:name, :description, :type, :website])
    |> validate_required([:name, :description, :type, :website])
  end
end
