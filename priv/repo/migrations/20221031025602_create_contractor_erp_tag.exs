defmodule BandwidthHero.Repo.Migrations.CreateContractorErpTag do
  use Ecto.Migration

  def change do
    create table(:contractor_erp_tags) do
      add :years, :integer
      add :projects, :integer
      add :contractor_id, references(:contractors, on_delete: :delete_all)
      add :erp_tag_id, references(:erp_tags, on_delete: :nothing)

      timestamps()
    end

    create index(:contractor_erp_tags, [:contractor_id])
    create index(:contractor_erp_tags, [:erp_tag_id])
  end
end
