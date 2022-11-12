defmodule BandwidthHeroWeb.OpportunityErpTagLive.Show do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.OpportunityErpTags
  alias BandwidthHero.Tags
  import BandwidthHeroWeb.OpportunityErpTagLive.Components

  @impl true
  def mount(_params, _session, socket) do
    select_options = Tags.list_erp_tags() |> Enum.map(&{&1.label, &1.id})

    {:ok,
     socket
     |> assign(:opportunity_id, nil)
     |> assign(:select_options, select_options)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    opportunity_erp_tag = OpportunityErpTags.get_opportunity_erp_tag!(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:opportunity_erp_tag, opportunity_erp_tag)
     |> assign(
       :return_to,
       Routes.opportunity_erp_tag_show_path(socket, :show, opportunity_erp_tag)
     )}
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp page_title(:show), do: "Show Opportunity erp tag"
  defp page_title(:edit), do: "Edit Opportunity erp tag"
end
