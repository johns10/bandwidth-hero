defmodule BandwidthHeroWeb.ExperienceLive.FormComponent do
  use BandwidthHeroWeb, :live_component

  import BandwidthHeroWeb.ExperienceLive.FormHandlers

  @impl true
  def update(assigns, socket) do
    update_socket(assigns, socket)
  end

  @impl true
  def handle_event("validate", %{"experience" => experience_params}, socket) do
    validate(experience_params, socket)
  end

  def handle_event("save", %{"experience" => experience_params}, socket) do
    save_redirect(socket, socket.assigns.action, experience_params)
  end
end
