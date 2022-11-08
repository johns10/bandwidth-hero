defmodule BandwidthHeroWeb.SourcerUserLive.FormHandlers do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.SourcerUsers
  alias BandwidthHero.SourcerUsers.SourcerUser

  @impl true
  def update_socket(%{sourcer_user: sourcer_user} = assigns, socket) do
    changeset = SourcerUsers.change_sourcer_user(sourcer_user)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def validate(params, socket) do
    changeset =
      socket.assigns.sourcer_user
      |> SourcerUsers.change_sourcer_user(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def save_redirect(socket, :edit, sourcer_user_params) do
    case SourcerUsers.update_sourcer_user(socket.assigns.sourcer_user, sourcer_user_params) do
      {:ok, _sourcer_user} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sourcer user updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_redirect(socket, :new, sourcer_user_params) do
    case SourcerUsers.create_sourcer_user(sourcer_user_params) do
      {:ok, _sourcer_user} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sourcer user created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def save_no_redirect(socket, :edit, sourcer_user_params) do
    case SourcerUsers.update_sourcer_user(socket.assigns.sourcer_user, sourcer_user_params) do
      {:ok, _sourcer_user} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sourcer user updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_no_redirect(socket, :new, sourcer_user_params) do
    case SourcerUsers.create_sourcer_user(sourcer_user_params) do
      {:ok, _sourcer_user} ->
        changeset = SourcerUsers.change_sourcer_user(%BandwidthHero.SourcerUsers.SourcerUser{})
        {:noreply,
         socket
         |> put_flash(:info, "Sourcer user created successfully")
         |> assign(:changeset, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
