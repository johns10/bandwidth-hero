defmodule BandwidthHeroWeb.SourcerLive.Show do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.Sourcers
  import BandwidthHeroWeb.SourcerLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    sourcer = Sourcers.get_sourcer!(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:sourcer, sourcer)
     |> assign(:return_to, Routes.sourcer_show_path(socket, :show, sourcer))}
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp page_title(:show), do: "Show Sourcer"
  defp page_title(:edit), do: "Edit Sourcer"
end
