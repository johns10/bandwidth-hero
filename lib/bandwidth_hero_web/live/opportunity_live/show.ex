defmodule BandwidthHeroWeb.OpportunityLive.Show do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.ListMatchingContractors
  alias BandwidthHero.Opportunities
  alias BandwidthHero.Opportunities.Opportunity
  alias BandwidthHero.OpportunityErpTags.OpportunityErpTag
  alias BandwidthHero.Tags
  alias BandwidthHeroWeb.OpportunityLive.Utils
  import BandwidthHeroWeb.OpportunityLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, action, %{"id" => id}) when action in [:show, :edit] do
    user = socket.assigns.current_user
    opportunity = get_opportunity!(id)
    erp_tags = Tags.list_erp_tags(filters: [parent_id: opportunity.pillar_id])
    matched_contractors = ListMatchingContractors.execute(opportunity)

    socket
    |> assign(:opportunity, opportunity)
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:erp_tags, erp_tags)
    |> assign(:opportunity_erp_tag_action, :show)
    |> assign(:return_to, Routes.opportunity_show_path(socket, :show, opportunity))
    |> assign(:matched_contractors, matched_contractors)
    |> assign(:can_update?, Utils.can_update_opportunity?(user, opportunity))
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  @impl true
  def handle_info(%{event: "update", payload: %Opportunity{} = opportunity}, socket) do
    {:noreply,
     socket
     |> assign(:opportunity, opportunity)
     |> schedule_get_matched_contractors()}
  end

  def handle_info(:get_matched_contractors, %{assigns: %{opportunity: opportunity}} = socket) do
    {:noreply,
     socket |> assign(:matched_contractors, ListMatchingContractors.execute(opportunity))}
  end

  def handle_info(%{event: event, payload: %OpportunityErpTag{}}, socket)
      when event in ["create", "delete", "update"] do
    opportunity = socket.assigns.opportunity

    {:noreply,
     socket
     |> assign(:opportunity, get_opportunity!(opportunity.id))
     |> schedule_get_matched_contractors()}
  end

  defp schedule_get_matched_contractors(%{assigns: %{timer: timer}} = socket) do
    Process.cancel_timer(timer)
    assign(socket, :timer, Process.send_after(self(), :get_matched_contractors, 1000))
  end

  defp schedule_get_matched_contractors(socket) do
    assign(socket, :timer, Process.send_after(self(), :get_matched_contractors, 1000))
  end

  defp get_opportunity!(id) do
    Opportunities.get_opportunity!(id, preloads: [opportunity_erp_tags: true])
  end

  def find_opportunity_erp_tag(%{opportunity_erp_tags: opportunity_erp_tags}, erp_tag_id) do
    opportunity_erp_tag =
      opportunity_erp_tags
      |> Enum.find(&(&1.erp_tag_id == erp_tag_id))

    opportunity_erp_tag || %OpportunityErpTag{}
  end

  defp page_title(:show), do: "Show Opportunity"
  defp page_title(:edit), do: "Edit Opportunity"
end
