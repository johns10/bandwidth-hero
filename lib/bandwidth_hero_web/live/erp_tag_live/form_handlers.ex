defmodule BandwidthHeroWeb.ErpTagLive.FormHandlers do
  import Phoenix.Component
  import Phoenix.LiveView

  alias BandwidthHero.Tags

  def update_socket(%{erp_tag: erp_tag} = assigns, socket) do
    changeset = Tags.change_erp_tag(erp_tag)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  def validate(params, socket) do
    changeset =
      socket.assigns.erp_tag
      |> Tags.change_erp_tag(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def save_redirect(socket, :edit, erp_tag_params) do
    case Tags.update_erp_tag(socket.assigns.erp_tag, erp_tag_params) do
      {:ok, _erp_tag} ->
        {:noreply,
         socket
         |> put_flash(:info, "Erp tag updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_redirect(socket, :new, erp_tag_params) do
    case Tags.create_erp_tag(erp_tag_params) do
      {:ok, _erp_tag} ->
        {:noreply,
         socket
         |> put_flash(:info, "Erp tag created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def save_no_redirect(socket, :edit, erp_tag_params) do
    case Tags.update_erp_tag(socket.assigns.erp_tag, erp_tag_params) do
      {:ok, _erp_tag} ->
        {:noreply,
         socket
         |> put_flash(:info, "Erp tag updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_no_redirect(socket, :new, erp_tag_params) do
    case Tags.create_erp_tag(erp_tag_params) do
      {:ok, _erp_tag} ->
        changeset = Tags.change_erp_tag(%BandwidthHero.Tags.ErpTag{})

        {:noreply,
         socket
         |> put_flash(:info, "Erp tag created successfully")
         |> assign(:changeset, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
