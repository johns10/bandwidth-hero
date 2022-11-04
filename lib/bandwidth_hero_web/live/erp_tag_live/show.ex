defmodule BandwidthHeroWeb.ErpTagLive.Show do
  use BandwidthHeroWeb, :live_view

  alias BandwidthHero.Tags
  import BandwidthHeroWeb.ErpTagLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    erp_tag = Tags.get_erp_tag!(id)
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:erp_tag, erp_tag)
     |> assign(:return_to, Routes.erp_tag_show_path(socket, :show, erp_tag))}
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp page_title(:show), do: "Show Erp tag"
  defp page_title(:edit), do: "Edit Erp tag"
end
