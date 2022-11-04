defmodule BandwidthHeroWeb.ContractorLive.FormComponent do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.Contractors
  import BandwidthHeroWeb.ContractorLive.FormHandlers

  @impl true
  def update(%{contractor: contractor} = assigns, socket) do
    update_socket(assigns, socket)
  end

  @impl true
  def handle_event("validate", %{"contractor" => contractor_params}, socket) do
    validate(contractor_params, socket)
  end

  def handle_event("save", %{"contractor" => contractor_params}, socket) do
    save_redirect(socket, socket.assigns.action, contractor_params)
  end
end
