defmodule BandwidthHero.Repo.Migrations.CreateErpTag do
  use Ecto.Migration

  def change do
    create table(:erp_tags) do
      add :label, :string
      add :parent_id, :string

      timestamps()
    end

    alter table(:erp_tags) do
      add :parent_erp_tag_id, references(:erp_tags, on_delete: :nilify_all)
    end
  end
end
