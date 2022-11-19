defmodule BandwidthHeroWeb.ContractorOpportunityLive.Show do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.ContractorOpportunities
  import BandwidthHeroWeb.ContractorOpportunityLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    contractor_opportunity = ContractorOpportunities.get_contractor_opportunity!(id)
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:contractor_opportunity, contractor_opportunity)
     |> assign(:return_to, Routes.contractor_opportunity_show_path(socket, :show, contractor_opportunity))}
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp page_title(:show), do: "Show Contractor opportunity"
  defp page_title(:edit), do: "Edit Contractor opportunity"
end
