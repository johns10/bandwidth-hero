defmodule BandwidthHero.Repo.Migrations.CreateOpportunityErpTags do
  use Ecto.Migration

  def change do
    create table(:opportunity_erp_tags) do
      add :years, :integer
      add :projects, :integer
      add :opportunity_id, references(:opportunities, on_delete: :nothing)
      add :erp_tag_id, references(:erp_tags, on_delete: :nothing)

      timestamps()
    end

    create index(:opportunity_erp_tags, [:opportunity_id])
    create index(:opportunity_erp_tags, [:erp_tag_id])
    create unique_index(:opportunity_erp_tags, [:opportunity_id, :erp_tag_id])
  end
end
