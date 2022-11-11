defmodule BandwidthHeroWeb.OpportunityLive.FormComponent do
  use BandwidthHeroWeb, :live_component

  import BandwidthHeroWeb.OpportunityLive.FormHandlers

  @impl true
  def update(assigns, socket) do
    update_socket(assigns, socket)
  end

  @impl true
  def handle_event("validate", %{"opportunity" => opportunity_params}, socket) do
    validate(opportunity_params, socket)
  end

  def handle_event("save", %{"opportunity" => opportunity_params}, socket) do
    save_redirect(socket, socket.assigns.action, opportunity_params)
  end
end
