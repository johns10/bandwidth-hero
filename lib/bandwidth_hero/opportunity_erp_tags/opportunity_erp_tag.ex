defmodule BandwidthHero.OpportunityErpTags.OpportunityErpTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias BandwidthHero.Opportunities.Opportunity
  alias BandwidthHero.Tags.ErpTag

  schema "opportunity_erp_tags" do
    field :projects, :integer
    field :years, :integer
    belongs_to :opportunity, Opportunity
    belongs_to :erp_tag, ErpTag

    timestamps()
  end

  @doc false
  def changeset(opportunity_erp_tag, attrs) do
    opportunity_erp_tag
    |> cast(attrs, [:opportunity_id, :erp_tag_id, :years, :projects])
    |> validate_required([:opportunity_id, :erp_tag_id])
  end
end
