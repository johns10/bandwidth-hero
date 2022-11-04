defmodule BandwidthHeroWeb.ErpTagLive.Index do
  use BandwidthHeroWeb, :live_view

  alias BandwidthHero.Tags
  alias BandwidthHero.Tags.ErpTag
  import BandwidthHeroWeb.ErpTagLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket
    |> assign(:erp_tag_collection, list_erp_tags())
    |> assign(:return_to, Routes.erp_tag_index_path(socket, :index))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Erp tag")
    |> assign(:erp_tag, Tags.get_erp_tag!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Erp tag")
    |> assign(:erp_tag, %ErpTag{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Erp tag")
    |> assign(:erp_tag, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    erp_tag = Tags.get_erp_tag!(id)
    {:ok, _} = Tags.delete_erp_tag(erp_tag)

    {:noreply, assign(socket, :erp_tag_collection, list_erp_tags())}
  end

  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp list_erp_tags do
    Tags.list_erp_tags()
  end
end
