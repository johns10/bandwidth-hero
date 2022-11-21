defmodule BandwidthHero.Contractors.Contractor do
  use Ecto.Schema
  import Ecto.Changeset
  alias BandwidthHero.ContractorErpTags.ContractorErpTag
  alias BandwidthHero.Availabilities.Availability
  alias BandwidthHero.Accounts.User
  alias BandwidthHero.ContractorOpportunities.ContractorOpportunity

  schema "contractors" do
    field :contract_type, {:array, Ecto.Enum}, values: [:corp_to_corp, :contract_w2, :"1099"]
    field :international_travel, Ecto.Enum, values: [:yes, :no, :maybe]
    field :laptop, {:array, Ecto.Enum}, values: [:use_my_own, :use_provided_laptop]
    field :name, :string
    field :title, :string
    field :travel, {:array, Ecto.Enum}, values: [:"100%", :"75%", :"50%", :"25%", :remote]

    belongs_to :user, User

    has_many :contractor_erp_tags, ContractorErpTag
    has_many :availabilities, Availability
    has_many :contractor_opportunities, ContractorOpportunity

    timestamps()
  end

  @doc false
  def changeset(contractor, attrs) do
    contractor
    |> cast(attrs, [
      :name,
      :title,
      :travel,
      :international_travel,
      :contract_type,
      :laptop,
      :user_id
    ])
    |> validate_required([
      :name,
      :title,
      :travel,
      :international_travel,
      :contract_type,
      :laptop
    ])
  end
end
