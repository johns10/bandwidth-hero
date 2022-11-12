defmodule BandwidthHeroWeb.SourcerUserLive.FormComponent do
  use BandwidthHeroWeb, :live_component

  import BandwidthHeroWeb.SourcerUserLive.FormHandlers

  @impl true
  def update(assigns, socket) do
    update_socket(assigns, socket)
  end

  @impl true
  def handle_event("validate", %{"sourcer_user" => sourcer_user_params}, socket) do
    validate(sourcer_user_params, socket)
  end

  def handle_event("save", %{"sourcer_user" => sourcer_user_params}, socket) do
    save_redirect(socket, socket.assigns.action, sourcer_user_params)
  end
end
