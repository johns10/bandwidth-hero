defmodule BandwidthHero.Tags.ErpTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "erp_tag" do
    field :label, :string
    field :type, Ecto.Enum, values: [:vendor, :platform, :pillar, :module, :""]

    belongs_to :parent_erp_tag, __MODULE__

    timestamps()
  end

  @doc false
  def changeset(erp_tag, attrs) do
    erp_tag
    |> cast(attrs, [:label, :type])
    |> validate_required([:label, :type])
  end
end
