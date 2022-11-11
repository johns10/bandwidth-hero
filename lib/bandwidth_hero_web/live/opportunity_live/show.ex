defmodule BandwidthHeroWeb.OpportunityLive.Show do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.Opportunities
  import BandwidthHeroWeb.OpportunityLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    opportunity = Opportunities.get_opportunity!(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:opportunity, opportunity)
     |> assign(:return_to, Routes.opportunity_show_path(socket, :show, opportunity))}
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp page_title(:show), do: "Show Opportunity"
  defp page_title(:edit), do: "Edit Opportunity"
end
