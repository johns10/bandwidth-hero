defmodule BandwidthHeroWeb.OpportunityErpTagLive.FormComponent do
  use BandwidthHeroWeb, :live_component

  import BandwidthHeroWeb.OpportunityErpTagLive.FormHandlers

  @impl true
  def update(assigns, socket) do
    update_socket(assigns, socket)
  end

  @impl true
  def handle_event("validate", %{"opportunity_erp_tag" => opportunity_erp_tag_params}, socket) do
    validate(opportunity_erp_tag_params, socket)
  end

  def handle_event("save", %{"opportunity_erp_tag" => opportunity_erp_tag_params}, socket) do
    save_redirect(socket, socket.assigns.action, opportunity_erp_tag_params)
  end
end
