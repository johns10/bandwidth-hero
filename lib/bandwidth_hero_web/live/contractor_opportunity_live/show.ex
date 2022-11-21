defmodule BandwidthHeroWeb.ContractorOpportunityLive.Show do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.ContractorOpportunities
  alias BandwidthHero.Opportunities
  import BandwidthHeroWeb.ContractorOpportunityLive.Components
  import BandwidthHeroWeb.OpportunityLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    contractor_opportunity = ContractorOpportunities.get_contractor_opportunity!(id)

    opportunity =
      contractor_opportunity.opportunity_id &&
        Opportunities.get_opportunity!(contractor_opportunity.opportunity_id,
          preloads: [opportunity_erp_tags: true]
        )

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:contractor_opportunity, contractor_opportunity)
     |> assign(:opportunity, opportunity)
     |> assign(
       :return_to,
       Routes.contractor_opportunity_show_path(socket, :show, contractor_opportunity)
     )}
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  def handle_event("accept_opportunity", _, socket) do
    attrs = %{contractor_decision: :accepted}
    update_contractor_opportunity(socket, attrs)
  end

  def handle_event("reject_opportunity", _, socket) do
    attrs = %{contractor_decision: :declined}
    update_contractor_opportunity(socket, attrs)
  end

  defp update_contractor_opportunity(socket, attrs) do
    contractor_opportunity = socket.assigns.contractor_opportunity

    case ContractorOpportunities.update_contractor_opportunity(contractor_opportunity, attrs) do
      {:ok, contractor_opportunity} ->
        {:noreply, socket |> assign(:contractor_opportunity, contractor_opportunity)}

      {:error, _} ->
        IO.puts("here")

        {:noreply, socket}
    end
  end

  defp page_title(:show), do: "Show Contractor opportunity"
  defp page_title(:edit), do: "Edit Contractor opportunity"
end
