defmodule BandwidthHeroWeb.OpportunityErpTagLive.Index do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.OpportunityErpTags
  alias BandwidthHero.OpportunityErpTags.OpportunityErpTag
  alias BandwidthHero.Tags
  import BandwidthHeroWeb.OpportunityErpTagLive.Components

  @impl true
  def mount(_params, _session, socket) do
    select_options = Tags.list_erp_tags() |> Enum.map(&{&1.label, &1.id})

    {:ok,
     socket
     |> assign(:opportunity_erp_tags, list_opportunity_erp_tags())
     |> assign(:opportunity_id, nil)
     |> assign(:select_options, select_options)
     |> assign(:return_to, Routes.opportunity_erp_tag_index_path(socket, :index))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Opportunity erp tag")
    |> assign(:opportunity_erp_tag, OpportunityErpTags.get_opportunity_erp_tag!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Opportunity erp tag")
    |> assign(:opportunity_erp_tag, %OpportunityErpTag{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Opportunity erp tags")
    |> assign(:opportunity_erp_tag, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    opportunity_erp_tag = OpportunityErpTags.get_opportunity_erp_tag!(id)
    {:ok, _} = OpportunityErpTags.delete_opportunity_erp_tag(opportunity_erp_tag)

    {:noreply, assign(socket, :opportunity_erp_tags, list_opportunity_erp_tags())}
  end

  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp list_opportunity_erp_tags do
    OpportunityErpTags.list_opportunity_erp_tags()
  end
end
