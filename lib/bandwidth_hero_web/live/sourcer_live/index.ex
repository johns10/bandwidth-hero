defmodule BandwidthHeroWeb.SourcerLive.Index do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.Sourcers
  alias BandwidthHero.Sourcers.Sourcer
  import BandwidthHeroWeb.SourcerLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:sourcers, list_sourcers())
     |> assign(:return_to, Routes.sourcer_index_path(socket, :index))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Sourcer")
    |> assign(:sourcer, Sourcers.get_sourcer!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Sourcer")
    |> assign(:sourcer, %Sourcer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Sourcers")
    |> assign(:sourcer, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    sourcer = Sourcers.get_sourcer!(id)
    {:ok, _} = Sourcers.delete_sourcer(sourcer)

    {:noreply, assign(socket, :sourcers, list_sourcers())}
  end

  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp list_sourcers do
    Sourcers.list_sourcers()
  end
end
