defmodule BandwidthHeroWeb.ContractorLive.Index do
  use BandwidthHeroWeb, :live_view

  alias BandwidthHero.Contractors
  alias BandwidthHero.Contractors.Contractor
  import BandwidthHeroWeb.ContractorLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket
    |> assign(:contractors, list_contractors())
    |> assign(:return_to, Routes.contractor_index_path(socket, :index))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit_erp_tag, %{"id" => id, "tag_id" => tag_id}) do
    contractor = Map.get(socket.assigns, :contractor)
    socket
    |> assign(:page_title, "Edit Tag")
    |> assign(:contractor, contractor || Contractors.get_contractor!(id))
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Contractor")
    |> assign(:contractor, Contractors.get_contractor!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Contractor")
    |> assign(:contractor, %Contractor{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Contractors")
    |> assign(:contractor, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    contractor = Contractors.get_contractor!(id)
    {:ok, _} = Contractors.delete_contractor(contractor)

    {:noreply, assign(socket, :contractors, list_contractors())}
  end

  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp list_contractors do
    Contractors.list_contractors()
  end
end
