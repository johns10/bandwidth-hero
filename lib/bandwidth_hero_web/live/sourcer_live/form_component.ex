defmodule BandwidthHeroWeb.SourcerLive.FormComponent do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.Sourcers
  alias BandwidthHero.SourcerUsers
  import BandwidthHeroWeb.SourcerLive.FormHandlers

  @impl true
  def update(assigns, socket) do
    update_socket(assigns, socket)
  end

  @impl true
  def handle_event("validate", %{"sourcer" => sourcer_params}, socket) do
    validate(sourcer_params, socket)
  end

  def handle_event("save", %{"sourcer" => sourcer_params}, socket) do
    save(socket, socket.assigns.action, sourcer_params)
  end

  def save(socket, :edit, sourcer_params) do
    case Sourcers.update_sourcer(socket.assigns.sourcer, sourcer_params) do
      {:ok, sourcer} ->
        {:ok, _} =
          %{sourcer_id: sourcer.id, user_id: socket.assigns.user.id}
          |> SourcerUsers.create_sourcer_user()

        {:noreply,
         socket
         |> put_flash(:info, "Sourcer updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save(socket, :new, sourcer_params) do
    case Sourcers.create_sourcer(sourcer_params) do
      {:ok, sourcer} ->
        {:ok, _} =
          %{sourcer_id: sourcer.id, user_id: socket.assigns.user.id}
          |> SourcerUsers.create_sourcer_user()

        {:noreply,
         socket
         |> put_flash(:info, "Sourcer created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
