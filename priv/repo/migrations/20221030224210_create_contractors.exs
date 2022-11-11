defmodule BandwidthHero.Repo.Migrations.CreateContractors do
  use Ecto.Migration

  def change do
    create table(:contractors) do
      add :name, :string
      add :title, :string

      add :travel, {:array, :string}
      add :international_travel, :string
      add :contract_type, {:array, :string}
      add :laptop, {:array, :string}

      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:contractors, [:user_id])
  end
end
