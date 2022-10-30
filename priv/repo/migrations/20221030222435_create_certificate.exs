defmodule BandwidthHero.Repo.Migrations.CreateCertificate do
  use Ecto.Migration

  def change do
    create table(:certificate) do
      add :label, :string
      add :description, :text

      timestamps()
    end
  end
end
