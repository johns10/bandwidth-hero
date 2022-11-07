defmodule BandwidthHeroWeb.ContractorLive.Utils do
  alias BandwidthHero.Contractors

  def can_update_contractor?(user, contractor) do
    case Bodyguard.permit(Contractors, :update_contractor, user, contractor) do
      :ok -> true
      {:error, _} -> false
    end
  end

  def commafy(list_of_values, acc \\ "")
  def commafy([_item | tail], acc), do: acc <> ", " <> commafy(tail, acc)
  def commafy([item | nil], acc), do: acc <> ", " <> item
  def commafy([], acc), do: acc
end
