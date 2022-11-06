defmodule BandwidthHeroWeb.CertificateLive.Index do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.Certificates
  alias BandwidthHero.Certificates.Certificate
  import BandwidthHeroWeb.CertificateLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:certificate_collection, list_certificate())
     |> assign(:return_to, Routes.certificate_index_path(socket, :index))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Certificate")
    |> assign(:certificate, Certificates.get_certificate!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Certificate")
    |> assign(:certificate, %Certificate{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Certificate")
    |> assign(:certificate, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    certificate = Certificates.get_certificate!(id)
    {:ok, _} = Certificates.delete_certificate(certificate)

    {:noreply, assign(socket, :certificate_collection, list_certificate())}
  end

  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp list_certificate do
    Certificates.list_certificate()
  end
end
