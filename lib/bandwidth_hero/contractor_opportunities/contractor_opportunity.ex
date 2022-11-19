defmodule BandwidthHero.ContractorOpportunities.ContractorOpportunity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contractor_opportunities" do
    field :message, :string
    field :subject, :string
    field :opportunity_id, :id
    field :contractor_id, :id

    timestamps()
  end

  @doc false
  def changeset(contractor_opportunity, attrs) do
    contractor_opportunity
    |> cast(attrs, [:subject, :message])
    |> validate_required([:subject, :message])
  end
end
