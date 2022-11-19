defmodule BandwidthHeroWeb.ContractorOpportunityLive.FormComponent do
  use BandwidthHeroWeb, :live_component

  import BandwidthHeroWeb.ContractorOpportunityLive.FormHandlers

  @impl true
  def update(assigns, socket) do
    assigns
    |> Map.put(:contractor_id, Map.get(assigns, :contractor_id, nil))
    |> Map.put(:opportunity_id, Map.get(assigns, :opportunity_id, nil))
    |> update_socket(socket)
  end

  @impl true
  def handle_event(
        "validate",
        %{"contractor_opportunity" => contractor_opportunity_params},
        socket
      ) do
    validate(contractor_opportunity_params, socket)
  end

  def handle_event("save", %{"contractor_opportunity" => contractor_opportunity_params}, socket) do
    save_redirect(socket, socket.assigns.action, contractor_opportunity_params)
  end
end
