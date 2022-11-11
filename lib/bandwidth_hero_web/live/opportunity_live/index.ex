defmodule BandwidthHeroWeb.OpportunityLive.Index do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.Opportunities
  alias BandwidthHero.Opportunities.Opportunity
  import BandwidthHeroWeb.OpportunityLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:opportunities, list_opportunities())
     |> assign(:return_to, Routes.opportunity_index_path(socket, :index))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Opportunity")
    |> assign(:opportunity, Opportunities.get_opportunity!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Opportunity")
    |> assign(:opportunity, %Opportunity{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Opportunities")
    |> assign(:opportunity, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    opportunity = Opportunities.get_opportunity!(id)
    {:ok, _} = Opportunities.delete_opportunity(opportunity)

    {:noreply, assign(socket, :opportunities, list_opportunities())}
  end

  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp list_opportunities do
    Opportunities.list_opportunities()
  end
end
