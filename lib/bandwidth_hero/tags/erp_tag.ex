defmodule BandwidthHero.Tags.ErpTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias BandwidthHero.Fields

  schema "erp_tags" do
    field :label, :string
    field :parent_id, Ecto.Enum, values: Fields.pillar_enum()

    timestamps()
  end

  @doc false
  def changeset(erp_tag, attrs) do
    erp_tag
    |> cast(attrs, [:label])
    |> validate_required([:label])
  end
end
