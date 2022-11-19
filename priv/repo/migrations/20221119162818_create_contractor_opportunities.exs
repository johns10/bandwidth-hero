defmodule BandwidthHero.Repo.Migrations.CreateContractorOpportunities do
  use Ecto.Migration

  def change do
    create table(:contractor_opportunities) do
      add :subject, :string
      add :message, :text
      add :opportunity_id, references(:opportunities, on_delete: :nothing)
      add :contractor_id, references(:contractors, on_delete: :nothing)

      timestamps()
    end

    create index(:contractor_opportunities, [:opportunity_id])
    create index(:contractor_opportunities, [:contractor_id])
  end
end
