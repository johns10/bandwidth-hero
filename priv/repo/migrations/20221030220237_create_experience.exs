defmodule BandwidthHero.Repo.Migrations.CreateExperience do
  use Ecto.Migration

  def change do
    create table(:experiences) do
      add :label, :string
      add :description, :text
      add :from, :date
      add :to, :date

      timestamps()
    end
  end
end
