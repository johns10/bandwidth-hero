defmodule BandwidthHero.Repo.Migrations.CreateContractorErpTag do
  use Ecto.Migration

  def change do
    create table(:contractor_erp_tag) do
      add :years, :integer
      add :projects, :integer
      add :contractor_id, references(:contractor, on_delete: :nothing)
      add :erp_tag_id, references(:erp_tag, on_delete: :nothing)

      timestamps()
    end

    create index(:contractor_erp_tag, [:contractor_id])
    create index(:contractor_erp_tag, [:erp_tag_id])
  end
end
