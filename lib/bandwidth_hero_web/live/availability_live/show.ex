defmodule BandwidthHeroWeb.AvailabilityLive.Show do
  use BandwidthHeroWeb, :live_view

  alias BandwidthHero.Availabilities
  import BandwidthHeroWeb.AvailabilityLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    availability = Availabilities.get_availability!(id)
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:availability, availability)
     |> assign(:return_to, Routes.availability_show_path(socket, :show, availability))}
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp page_title(:show), do: "Show Availability"
  defp page_title(:edit), do: "Edit Availability"
end
