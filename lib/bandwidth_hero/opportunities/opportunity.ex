defmodule BandwidthHero.Opportunities.Opportunity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "opportunities" do
    field :contract_type, Ecto.Enum, values: [:corp_to_corp, :contract_w2, :"1099"]
    field :description, :string
    field :from_date, :date
    field :hours, :integer
    field :laptop, Ecto.Enum, values: [:use_my_own, :use_provided_laptop]
    field :name, :string
    field :rate, :decimal
    field :to_date, :date
    field :travel, Ecto.Enum, values: [:"100%", :"75%", :"50%", :"25%", :none]
    field :sourcer_id, :id

    timestamps()
  end

  @doc false
  def changeset(opportunity, attrs) do
    opportunity
    |> cast(attrs, [:name, :description, :from_date, :to_date, :rate, :hours, :travel, :contract_type, :laptop])
    |> validate_required([:name, :description, :from_date, :to_date, :rate, :hours, :travel, :contract_type, :laptop])
  end
end
