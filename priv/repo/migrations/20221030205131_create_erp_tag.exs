defmodule BandwidthHero.Repo.Migrations.CreateErpTag do
  use Ecto.Migration

  def change do
    create table(:erp_tag) do
      add :label, :string
      add :type, :string

      timestamps()
    end

    alter table(:erp_tag) do
      add :parent_erp_tag_id, references(:erp_tag, on_delete: :nilify_all)
    end
  end
end
