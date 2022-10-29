defmodule BandwidthHero.Repo do
  use Ecto.Repo,
    otp_app: :bandwidth_hero,
    adapter: Ecto.Adapters.Postgres
end
