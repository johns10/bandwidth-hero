defmodule BandwidthHeroWeb.CertificateLive.FormComponent do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.Certificates
  import BandwidthHeroWeb.CertificateLive.FormHandlers

  @impl true
  def update(%{certificate: certificate} = assigns, socket) do
    update_socket(assigns, socket)
  end

  @impl true
  def handle_event("validate", %{"certificate" => certificate_params}, socket) do
    validate(certificate_params, socket)
  end

  def handle_event("save", %{"certificate" => certificate_params}, socket) do
    save_redirect(socket, socket.assigns.action, certificate_params)
  end
end
