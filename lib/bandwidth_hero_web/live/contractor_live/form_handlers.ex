defmodule BandwidthHeroWeb.ContractorLive.FormHandlers do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.Contractors
  alias BandwidthHero.Contractors.Contractor

  @impl true
  def update_socket(%{contractor: contractor} = assigns, socket) do
    changeset = Contractors.change_contractor(contractor)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def validate(params, socket) do
    changeset =
      socket.assigns.contractor
      |> Contractors.change_contractor(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def save_redirect(socket, :edit, contractor_params) do
    case Contractors.update_contractor(socket.assigns.contractor, contractor_params) do
      {:ok, _contractor} ->
        {:noreply,
         socket
         |> put_flash(:info, "Contractor updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_redirect(socket, :new, contractor_params) do
    case Contractors.create_contractor(contractor_params) do
      {:ok, _contractor} ->
        {:noreply,
         socket
         |> put_flash(:info, "Contractor created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def save_no_redirect(socket, :edit, contractor_params) do
    case Contractors.update_contractor(socket.assigns.contractor, contractor_params) do
      {:ok, _contractor} ->
        {:noreply,
         socket
         |> put_flash(:info, "Contractor updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_no_redirect(socket, :new, contractor_params) do
    case Contractors.create_contractor(contractor_params) do
      {:ok, _contractor} ->
        changeset = Contractors.change_contractor(%BandwidthHero.Contractors.Contractor{})
        {:noreply,
         socket
         |> put_flash(:info, "Contractor created successfully")
         |> assign(:changeset, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
