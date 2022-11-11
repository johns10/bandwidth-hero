defmodule BandwidthHeroWeb.OpportunityErpTagLive.FormHandlers do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.OpportunityErpTags
  alias BandwidthHero.OpportunityErpTags.OpportunityErpTag

  @impl true
  def update_socket(%{opportunity_erp_tag: opportunity_erp_tag} = assigns, socket) do
    changeset = OpportunityErpTags.change_opportunity_erp_tag(opportunity_erp_tag)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def validate(params, socket) do
    changeset =
      socket.assigns.opportunity_erp_tag
      |> OpportunityErpTags.change_opportunity_erp_tag(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def save_redirect(socket, :edit, opportunity_erp_tag_params) do
    case OpportunityErpTags.update_opportunity_erp_tag(socket.assigns.opportunity_erp_tag, opportunity_erp_tag_params) do
      {:ok, _opportunity_erp_tag} ->
        {:noreply,
         socket
         |> put_flash(:info, "Opportunity erp tag updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_redirect(socket, :new, opportunity_erp_tag_params) do
    case OpportunityErpTags.create_opportunity_erp_tag(opportunity_erp_tag_params) do
      {:ok, _opportunity_erp_tag} ->
        {:noreply,
         socket
         |> put_flash(:info, "Opportunity erp tag created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def save_no_redirect(socket, :edit, opportunity_erp_tag_params) do
    case OpportunityErpTags.update_opportunity_erp_tag(socket.assigns.opportunity_erp_tag, opportunity_erp_tag_params) do
      {:ok, _opportunity_erp_tag} ->
        {:noreply,
         socket
         |> put_flash(:info, "Opportunity erp tag updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_no_redirect(socket, :new, opportunity_erp_tag_params) do
    case OpportunityErpTags.create_opportunity_erp_tag(opportunity_erp_tag_params) do
      {:ok, _opportunity_erp_tag} ->
        changeset = OpportunityErpTags.change_opportunity_erp_tag(%BandwidthHero.OpportunityErpTags.OpportunityErpTag{})
        {:noreply,
         socket
         |> put_flash(:info, "Opportunity erp tag created successfully")
         |> assign(:changeset, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
