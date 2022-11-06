defmodule BandwidthHero.Repo.Migrations.CreateContractors do
  use Ecto.Migration

  def change do
    create table(:contractors) do
      add :name, :string
      add :title, :string
      add :availability, :string
      add :bandwidth, :integer
      add :travel, :string
      add :international_travel, :string
      add :contract_type, :string
      add :laptop, :string

      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:contractors, [:user_id])
  end
end
