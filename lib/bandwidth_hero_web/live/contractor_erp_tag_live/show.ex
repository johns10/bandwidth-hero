defmodule BandwidthHeroWeb.ContractorErpTagLive.Show do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.ContractorErpTags
  import BandwidthHeroWeb.ContractorErpTagLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    contractor_erp_tag = ContractorErpTags.get_contractor_erp_tag!(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:contractor_erp_tag, contractor_erp_tag)
     |> assign(:return_to, Routes.contractor_erp_tag_show_path(socket, :show, contractor_erp_tag))}
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp page_title(:show), do: "Show Contractor erp tag"
  defp page_title(:edit), do: "Edit Contractor erp tag"
end
