defmodule BandwidthHeroWeb.ContractorErpTagLive.Index do
  use BandwidthHeroWeb, :live_view

  alias BandwidthHero.Tags
  alias BandwidthHero.ContractorErpTags
  alias BandwidthHero.ContractorErpTags.ContractorErpTag
  import BandwidthHeroWeb.ContractorErpTagLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket
    |> assign(:contractor_erp_tag_collection, list_contractor_erp_tags())
    |> assign(:return_to, Routes.contractor_erp_tag_index_path(socket, :index))
    |> assign(:erp_tag_select_options, Tags.list_erp_tags() |> Enum.map(& {&1.label, &1.id}))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Contractor erp tag")
    |> assign(:contractor_erp_tag, ContractorErpTags.get_contractor_erp_tag!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Contractor erp tag")
    |> assign(:contractor_erp_tag, %ContractorErpTag{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Contractor erp tag")
    |> assign(:contractor_erp_tag, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    contractor_erp_tag = ContractorErpTags.get_contractor_erp_tag!(id)
    {:ok, _} = ContractorErpTags.delete_contractor_erp_tag(contractor_erp_tag)

    {:noreply, assign(socket, :contractor_erp_tag_collection, list_contractor_erp_tags())}
  end

  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp list_contractor_erp_tags do
    ContractorErpTags.list_contractor_erp_tags()
  end
end
