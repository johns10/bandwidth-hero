defmodule BandwidthHero.Opportunities.RequiredSkills do
  use Ecto.Schema
  import Ecto.Changeset
  alias BandwidthHero.OpportunityErpTags.OpportunityErpTag

  embedded_schema do
    field :vendor_id, :integer
    embeds_one :vendor, OpportunityErpTag
    field :platform_id, :integer
    embeds_one :platform, OpportunityErpTag
    field :pillar_id, :integer
    embeds_one :pillar, OpportunityErpTag
    field :module_ids, {:array, :integer}
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:vendor_id, :platform_id, :pillar_id, :module_ids])
    |> case do
      %{changes: %{vendor_id: vendor_id}} = changeset ->
        changeset

      changeset ->
        changeset
    end
  end
end
