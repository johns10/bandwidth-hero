defmodule BandwidthHero.OpportunityErpTags.OpportunityErpTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "opportunity_erp_tags" do
    field :projects, :integer
    field :years, :integer
    field :opportunity_id, :id
    field :erp_tag_id, :id

    timestamps()
  end

  @doc false
  def changeset(opportunity_erp_tag, attrs) do
    opportunity_erp_tag
    |> cast(attrs, [:years, :projects])
    |> validate_required([:years, :projects])
  end
end
