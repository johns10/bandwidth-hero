defmodule BandwidthHeroWeb.ContractorErpTagLive.FormHandlers do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.ContractorErpTags
  alias BandwidthHero.ContractorErpTags.ContractorErpTag

  @impl true
  def update_socket(%{contractor_erp_tag: contractor_erp_tag} = assigns, socket) do
    changeset = ContractorErpTags.change_contractor_erp_tag(contractor_erp_tag)
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def validate(params, socket) do
    changeset =
      socket.assigns.contractor_erp_tag
      |> ContractorErpTags.change_contractor_erp_tag(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def save_redirect(socket, action, contractor_erp_tag_params) when action in [:edit, :edit_erp_tag] do
    case ContractorErpTags.update_contractor_erp_tag(socket.assigns.contractor_erp_tag, contractor_erp_tag_params) do
      {:ok, _contractor_erp_tag} ->
        {:noreply,
         socket
         |> put_flash(:info, "Contractor erp tag updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_redirect(socket, action, contractor_erp_tag_params) when action in [:new, :new_erp_tag] do
    case ContractorErpTags.create_contractor_erp_tag(contractor_erp_tag_params) do
      {:ok, _contractor_erp_tag} ->
        {:noreply,
         socket
         |> put_flash(:info, "Contractor erp tag created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def save_no_redirect(socket, :edit, contractor_erp_tag_params) do
    case ContractorErpTags.update_contractor_erp_tag(socket.assigns.contractor_erp_tag, contractor_erp_tag_params) do
      {:ok, _contractor_erp_tag} ->
        {:noreply,
         socket
         |> put_flash(:info, "Contractor erp tag updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_no_redirect(socket, :new, contractor_erp_tag_params) do
    case ContractorErpTags.create_contractor_erp_tag(contractor_erp_tag_params) do
      {:ok, _contractor_erp_tag} ->
        changeset = ContractorErpTags.change_contractor_erp_tag(%BandwidthHero.ContractorErpTags.ContractorErpTag{})
        {:noreply,
         socket
         |> put_flash(:info, "Contractor erp tag created successfully")
         |> assign(:changeset, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
