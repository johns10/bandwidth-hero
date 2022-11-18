defmodule BandwidthHero.Repo.Migrations.CreateSourcers do
  use Ecto.Migration

  def change do
    create table(:sourcers) do
      add :name, :string
      add :description, :text
      add :type, :string
      add :website, :string

      timestamps()
    end
  end
end
