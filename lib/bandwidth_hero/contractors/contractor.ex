defmodule BandwidthHero.Contractors.Contractor do
  use Ecto.Schema
  import Ecto.Changeset
  alias BandwidthHero.ContractorErpTags.ContractorErpTag

  schema "contractors" do
    field :availability, Ecto.Enum, values: [:full, :partial, :none]
    field :bandwidth, :integer
    field :contract_type, Ecto.Enum, values: [:corp_to_corp, :contract_w2, :"1099"]
    field :international_travel, Ecto.Enum, values: [:yes, :no, :maybe]
    field :laptop, Ecto.Enum, values: [:use_my_own, :use_provided_laptop]
    field :name, :string
    field :title, :string
    field :travel, Ecto.Enum, values: [:"100%", :"75%", :"50%", :"25%", :remote]

    has_many :contractor_erp_tags, ContractorErpTag

    timestamps()
  end

  @doc false
  def changeset(contractor, attrs) do
    contractor
    |> cast(attrs, [:name, :title, :availability, :bandwidth, :travel, :international_travel, :contract_type, :laptop])
    |> validate_required([:name, :title, :availability, :bandwidth, :travel, :international_travel, :contract_type, :laptop])
  end
end
