defmodule BandwidthHeroWeb.ContractorOpportunityLive.ContractorIndex do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.ContractorOpportunities
  import BandwidthHeroWeb.ContractorOpportunityLive.Components

  @impl true
  def mount(%{"contractor_id" => contractor_id}, _session, socket) do
    contractor_opportunities = list_contractor_opportunities(contractor_id)

    {:ok,
     socket
     |> assign(:contractor_opportunities, contractor_opportunities)
     |> assign(:return_to, Routes.contractor_opportunity_index_path(socket, :index))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Contractor opportunity")
    |> assign(:contractor_opportunity, ContractorOpportunities.get_contractor_opportunity!(id))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Contractor opportunities")
    |> assign(:contractor_opportunity, nil)
  end

  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp list_contractor_opportunities(contractor_id) do
    ContractorOpportunities.list_contractor_opportunities(filters: [contractor_id: contractor_id])
  end
end
