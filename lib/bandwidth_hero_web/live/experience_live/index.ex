defmodule BandwidthHeroWeb.ExperienceLive.Index do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.Experiences
  alias BandwidthHero.Experiences.Experience
  import BandwidthHeroWeb.ExperienceLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:experience_collection, list_experiences())
     |> assign(:return_to, Routes.experience_index_path(socket, :index))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Experience")
    |> assign(:experience, Experiences.get_experience!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Experience")
    |> assign(:experience, %Experience{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Experience")
    |> assign(:experience, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    experience = Experiences.get_experience!(id)
    {:ok, _} = Experiences.delete_experience(experience)

    {:noreply, assign(socket, :experience_collection, list_experiences())}
  end

  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp list_experiences do
    Experiences.list_experiences()
  end
end
