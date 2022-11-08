defmodule BandwidthHeroWeb.SourcerUserLive.Show do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.SourcerUsers
  import BandwidthHeroWeb.SourcerUserLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    sourcer_user = SourcerUsers.get_sourcer_user!(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:sourcer_user, sourcer_user)
     |> assign(:return_to, Routes.sourcer_user_show_path(socket, :show, sourcer_user))}
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp page_title(:show), do: "Show Sourcer user"
  defp page_title(:edit), do: "Edit Sourcer user"
end
