defmodule BandwidthHeroWeb.ContractorOpportunityLive.FormComponent do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.ContractorOpportunities
  import BandwidthHeroWeb.ContractorOpportunityLive.FormHandlers

  @impl true
  def update(%{contractor_opportunity: contractor_opportunity} = assigns, socket) do
    update_socket(assigns, socket)
  end

  @impl true
  def handle_event("validate", %{"contractor_opportunity" => contractor_opportunity_params}, socket) do
    validate(contractor_opportunity_params, socket)
  end

  def handle_event("save", %{"contractor_opportunity" => contractor_opportunity_params}, socket) do
    save_redirect(socket, socket.assigns.action, contractor_opportunity_params)
  end
end
