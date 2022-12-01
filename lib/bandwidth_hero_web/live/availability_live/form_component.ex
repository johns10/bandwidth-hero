defmodule BandwidthHeroWeb.AvailabilityLive.FormComponent do
  use BandwidthHeroWeb, :live_component

  import BandwidthHeroWeb.AvailabilityLive.FormHandlers
  import BandwidthHeroWeb.LiveHelpers

  @impl true
  def update(assigns, socket) do
    contractor_id = Map.get(assigns, :contractor_id, nil)

    assigns
    |> Map.put(:contractor_id, contractor_id)
    |> update_socket(socket)
  end

  @impl true
  def handle_event("validate", %{"availability" => availability_params}, socket) do
    validate(availability_params, socket)
  end

  def handle_event("save", %{"availability" => availability_params}, socket) do
    save_redirect(socket, socket.assigns.action, availability_params)
  end
end
