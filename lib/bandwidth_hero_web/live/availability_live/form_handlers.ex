defmodule BandwidthHeroWeb.AvailabilityLive.FormHandlers do
  import Phoenix.Component
  import Phoenix.LiveView

  alias BandwidthHero.Availabilities

  def update_socket(%{availability: availability} = assigns, socket) do
    changeset = Availabilities.change_availability(availability)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  def validate(params, socket) do
    changeset =
      socket.assigns.availability
      |> Availabilities.change_availability(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def save_redirect(socket, :edit, availability_params) do
    case Availabilities.update_availability(socket.assigns.availability, availability_params) do
      {:ok, _availability} ->
        {:noreply,
         socket
         |> put_flash(:info, "Availability updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_redirect(socket, :new, availability_params) do
    case Availabilities.create_availability(availability_params) do
      {:ok, _availability} ->
        {:noreply,
         socket
         |> put_flash(:info, "Availability created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def save_no_redirect(socket, :edit, availability_params) do
    case Availabilities.update_availability(socket.assigns.availability, availability_params) do
      {:ok, _availability} ->
        {:noreply,
         socket
         |> put_flash(:info, "Availability updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_no_redirect(socket, :new, availability_params) do
    case Availabilities.create_availability(availability_params) do
      {:ok, _availability} ->
        changeset =
          Availabilities.change_availability(%BandwidthHero.Availabilities.Availability{})

        {:noreply,
         socket
         |> put_flash(:info, "Availability created successfully")
         |> assign(:changeset, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
