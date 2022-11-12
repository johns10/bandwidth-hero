defmodule BandwidthHero.Repo.Migrations.CreateOpportunities do
  use Ecto.Migration

  def change do
    create table(:opportunities) do
      add :name, :string
      add :description, :text
      add :from_date, :date
      add :to_date, :date
      add :rate, :decimal
      add :hours_per_week, :integer
      add :vendor_id, :string
      add :pillar_id, :string
      add :platform_id, :string

      add :travel, {:array, :string}
      add :contract_type, {:array, :string}
      add :laptop, {:array, :string}

      add :sourcer_id, references(:sourcers, on_delete: :nothing)

      timestamps()
    end

    create index(:opportunities, [:sourcer_id])
  end
end
