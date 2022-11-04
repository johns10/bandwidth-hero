defmodule BandwidthHero.ContractorErpTags.ContractorErpTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias BandwidthHero.Contractors.Contractor
  alias BandwidthHero.Tags.ErpTag

  schema "contractor_erp_tag" do
    field :projects, :integer
    field :years, :integer
    belongs_to :contractor, Contractor
    belongs_to :erp_tag, ErpTag

    timestamps()
  end

  @doc false
  def changeset(contractor_erp_tag, attrs) do
    contractor_erp_tag
    |> cast(attrs, [:contractor_id, :erp_tag_id, :years, :projects])
    |> validate_required([:contractor_id, :erp_tag_id])
  end
end
