defmodule BandwidthHero.Repo.Migrations.CreateAvailabilities do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS btree_gist"

    create table(:availabilities) do
      add :available_from, :date
      add :available_to, :date
      add :hours, :integer
      add :contractor_id, references(:contractors, on_delete: :nothing)

      timestamps()
    end

    create index(:availabilities, [:contractor_id])

    create constraint(
             "availabilities",
             :no_overlaps,
             exclude:
               ~s|gist(contractor_id WITH =, daterange(available_from, available_to) WITH &&)|
           )
  end
end
