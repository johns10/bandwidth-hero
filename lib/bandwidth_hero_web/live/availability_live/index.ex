defmodule BandwidthHeroWeb.AvailabilityLive.Index do
  use BandwidthHeroWeb, :live_view

  alias BandwidthHero.Availabilities
  alias BandwidthHero.Availabilities.Availability
  import BandwidthHeroWeb.AvailabilityLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket
    |> assign(:availabilities, list_availabilities())
    |> assign(:return_to, Routes.availability_index_path(socket, :index))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Availability")
    |> assign(:availability, Availabilities.get_availability!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Availability")
    |> assign(:availability, %Availability{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Availabilities")
    |> assign(:availability, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    availability = Availabilities.get_availability!(id)
    {:ok, _} = Availabilities.delete_availability(availability)

    {:noreply, assign(socket, :availabilities, list_availabilities())}
  end

  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp list_availabilities do
    Availabilities.list_availabilities()
  end
end
