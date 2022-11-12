defmodule BandwidthHero.Repo.Migrations.CreateErpTag do
  use Ecto.Migration

  def change do
    create table(:erp_tags) do
      add :label, :string
      add :parent_id, :string

      timestamps()
    end
  end
end
