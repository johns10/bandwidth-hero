defmodule BandwidthHero.ContractorOpportunities.ContractorOpportunity do
  alias BandwidthHero.Opportunities.Opportunity
  use Ecto.Schema
  import Ecto.Changeset
  alias BandwidthHero.Contractors.Contractor
  alias BandwidthHero.Opportunities.Opportunity

  schema "contractor_opportunities" do
    field :message, :string
    field :subject, :string
    field :contractor_decision, Ecto.Enum, values: [nil, :accepted, :declined]
    belongs_to :opportunity, Opportunity
    belongs_to :contractor, Contractor

    timestamps()
  end

  @doc false
  def changeset(contractor_opportunity, attrs) do
    contractor_opportunity
    |> cast(attrs, [:subject, :message, :opportunity_id, :contractor_id, :contractor_decision])
    |> validate_required([:subject, :message])
  end
end
