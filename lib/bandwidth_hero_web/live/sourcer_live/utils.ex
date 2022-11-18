defmodule BandwidthHeroWeb.SourcerLive.Utils do
  alias BandwidthHero.Sourcers

  def can_update_sourcer?(user, sourcer) do
    case Bodyguard.permit(Sourcers, :update_sourcer, user, sourcer) do
      :ok -> true
      {:error, _} -> false
    end
  end
end
