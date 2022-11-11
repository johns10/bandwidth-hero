defmodule BandwidthHero.Opportunities.Opportunity do
  use Ecto.Schema
  import Ecto.Changeset
  alias BandwidthHero.Sourcers.Sourcer

  schema "opportunities" do
    field :description, :string
    field :from_date, :date
    field :hours_per_week, :integer
    field :name, :string
    field :rate, :decimal
    field :to_date, :date

    field :laptop, {:array, Ecto.Enum}, values: [:use_my_own, :use_provided_laptop]
    field :contract_type, {:array, Ecto.Enum}, values: [:corp_to_corp, :contract_w2, :"1099"]
    field :travel, {:array, Ecto.Enum}, values: [:"100%", :"75%", :"50%", :"25%", :none]

    belongs_to :sourcer, Sourcer

    timestamps()
  end

  @doc false
  def changeset(opportunity, attrs) do
    opportunity
    |> cast(attrs, [
      :name,
      :description,
      :from_date,
      :to_date,
      :rate,
      :hours_per_week,
      :travel,
      :contract_type,
      :laptop,
      :sourcer_id
    ])
    |> validate_required([
      :name,
      :description,
      :from_date,
      :to_date,
      :rate,
      :hours_per_week,
      :travel,
      :contract_type,
      :laptop
    ])
    |> foreign_key_constraint(:sourcer)
  end
end
