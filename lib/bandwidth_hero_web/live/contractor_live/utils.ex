defmodule BandwidthHeroWeb.ContractorLive.Utils do
  alias BandwidthHero.Contractors

  def can_update_contractor?(user, contractor) do
    IO.inspect(contractor)

    case Bodyguard.permit(Contractors, :update_contractor, user, contractor) do
      :ok -> true
      {:error, _} -> false
    end
  end
end
