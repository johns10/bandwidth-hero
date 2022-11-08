defmodule BandwidthHero.SourcerUsers.SourcerUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias BandwidthHero.Accounts.User
  alias BandwidthHero.Sourcers.Sourcer

  schema "sourcer_users" do
    field :position, :string
    belongs_to :user, User
    belongs_to :sourcer, Sourcer

    timestamps()
  end

  @doc false
  def changeset(sourcer_user, attrs) do
    sourcer_user
    |> cast(attrs, [:user_id, :sourcer_id, :position])
    |> validate_required([:user_id, :sourcer_id])
  end
end
