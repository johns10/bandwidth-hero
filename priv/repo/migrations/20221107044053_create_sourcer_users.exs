defmodule BandwidthHero.Repo.Migrations.CreateSourcerUsers do
  use Ecto.Migration

  def change do
    create table(:sourcer_users) do
      add :position, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :sourcer_id, references(:sourcers, on_delete: :delete_all)

      timestamps()
    end

    create index(:sourcer_users, [:user_id])
    create index(:sourcer_users, [:sourcer_id])
  end
end
