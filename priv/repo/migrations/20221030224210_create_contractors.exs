defmodule BandwidthHero.Repo.Migrations.CreateContractors do
  use Ecto.Migration

  def change do
    create table(:contractor) do
      add :name, :string
      add :title, :string
      add :availability, :string
      add :bandwidth, :integer
      add :travel, :string
      add :international_travel, :string
      add :contract_type, :string
      add :laptop, :string

      timestamps()
    end
  end
end
