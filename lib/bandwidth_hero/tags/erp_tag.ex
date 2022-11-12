defmodule BandwidthHero.Tags.ErpTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias BandwidthHero.Fields

  schema "erp_tags" do
    field :label, :string
    field :type, Ecto.Enum, values: [:vendor, :platform, :pillar, :module, :""]
    field :parent_id, Ecto.Enum, values: Fields.pillar_enum()

    belongs_to :parent_erp_tag, __MODULE__

    timestamps()
  end

  @doc false
  def changeset(erp_tag, attrs) do
    erp_tag
    |> cast(attrs, [:label, :type, :parent_id])
    |> validate_required([:label, :type])
  end
end
