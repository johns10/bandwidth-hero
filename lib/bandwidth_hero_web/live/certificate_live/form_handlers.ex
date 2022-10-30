defmodule BandwidthHeroWeb.CertificateLive.FormHandlers do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.Certificates
  alias BandwidthHero.Certificates.Certificate

  @impl true
  def update_socket(%{certificate: certificate} = assigns, socket) do
    changeset = Certificates.change_certificate(certificate)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def validate(params, socket) do
    changeset =
      socket.assigns.certificate
      |> Certificates.change_certificate(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def save_redirect(socket, :edit, certificate_params) do
    case Certificates.update_certificate(socket.assigns.certificate, certificate_params) do
      {:ok, _certificate} ->
        {:noreply,
         socket
         |> put_flash(:info, "Certificate updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_redirect(socket, :new, certificate_params) do
    case Certificates.create_certificate(certificate_params) do
      {:ok, _certificate} ->
        {:noreply,
         socket
         |> put_flash(:info, "Certificate created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def save_no_redirect(socket, :edit, certificate_params) do
    case Certificates.update_certificate(socket.assigns.certificate, certificate_params) do
      {:ok, _certificate} ->
        {:noreply,
         socket
         |> put_flash(:info, "Certificate updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_no_redirect(socket, :new, certificate_params) do
    case Certificates.create_certificate(certificate_params) do
      {:ok, _certificate} ->
        changeset = Certificates.change_certificate(%BandwidthHero.Certificates.Certificate{})
        {:noreply,
         socket
         |> put_flash(:info, "Certificate created successfully")
         |> assign(:changeset, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
