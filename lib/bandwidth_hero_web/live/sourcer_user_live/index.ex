defmodule BandwidthHeroWeb.SourcerUserLive.Index do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.SourcerUsers
  alias BandwidthHero.SourcerUsers.SourcerUser
  import BandwidthHeroWeb.SourcerUserLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:sourcer_users, list_sourcer_users())
     |> assign(:return_to, Routes.sourcer_user_index_path(socket, :index))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Sourcer user")
    |> assign(:sourcer_user, SourcerUsers.get_sourcer_user!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Sourcer user")
    |> assign(:sourcer_user, %SourcerUser{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Sourcer users")
    |> assign(:sourcer_user, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    sourcer_user = SourcerUsers.get_sourcer_user!(id)
    {:ok, _} = SourcerUsers.delete_sourcer_user(sourcer_user)

    {:noreply, assign(socket, :sourcer_users, list_sourcer_users())}
  end

  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp list_sourcer_users do
    SourcerUsers.list_sourcer_users()
  end
end
