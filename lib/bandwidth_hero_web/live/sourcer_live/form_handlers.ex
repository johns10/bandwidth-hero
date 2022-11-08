defmodule BandwidthHeroWeb.SourcerLive.FormHandlers do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.Sourcers
  alias BandwidthHero.Sourcers.Sourcer

  @impl true
  def update_socket(%{sourcer: sourcer} = assigns, socket) do
    changeset = Sourcers.change_sourcer(sourcer)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def validate(params, socket) do
    changeset =
      socket.assigns.sourcer
      |> Sourcers.change_sourcer(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def save_redirect(socket, :edit, sourcer_params) do
    case Sourcers.update_sourcer(socket.assigns.sourcer, sourcer_params) do
      {:ok, _sourcer} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sourcer updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_redirect(socket, :new, sourcer_params) do
    case Sourcers.create_sourcer(sourcer_params) do
      {:ok, _sourcer} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sourcer created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def save_no_redirect(socket, :edit, sourcer_params) do
    case Sourcers.update_sourcer(socket.assigns.sourcer, sourcer_params) do
      {:ok, _sourcer} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sourcer updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_no_redirect(socket, :new, sourcer_params) do
    case Sourcers.create_sourcer(sourcer_params) do
      {:ok, _sourcer} ->
        changeset = Sourcers.change_sourcer(%BandwidthHero.Sourcers.Sourcer{})
        {:noreply,
         socket
         |> put_flash(:info, "Sourcer created successfully")
         |> assign(:changeset, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
