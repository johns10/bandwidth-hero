defmodule BandwidthHeroWeb.OpportunityLive.Utils do
  alias BandwidthHero.Opportunities

  def can_update_opportunity?(user, opportunity) do
    case Bodyguard.permit(Opportunities, :update_opportunity, user, opportunity) do
      :ok -> true
      {:error, _} -> false
    end
  end
end
