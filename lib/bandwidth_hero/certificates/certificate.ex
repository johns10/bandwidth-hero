defmodule BandwidthHero.Certificates.Certificate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "certificate" do
    field :description, :string
    field :label, :string

    timestamps()
  end

  @doc false
  def changeset(certificate, attrs) do
    certificate
    |> cast(attrs, [:label, :description])
    |> validate_required([:label, :description])
  end
end
