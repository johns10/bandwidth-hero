defmodule BandwidthHeroWeb.ContractorOpportunityLive.FormHandlers do
  import Phoenix.Component
  import Phoenix.LiveView

  alias BandwidthHero.ContractorOpportunities

  def update_socket(%{contractor_opportunity: contractor_opportunity} = assigns, socket) do
    changeset = ContractorOpportunities.change_contractor_opportunity(contractor_opportunity)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  def validate(params, socket) do
    changeset =
      socket.assigns.contractor_opportunity
      |> ContractorOpportunities.change_contractor_opportunity(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def save_redirect(socket, :edit, contractor_opportunity_params) do
    case ContractorOpportunities.update_contractor_opportunity(
           socket.assigns.contractor_opportunity,
           contractor_opportunity_params
         ) do
      {:ok, _contractor_opportunity} ->
        {:noreply,
         socket
         |> put_flash(:info, "Contractor opportunity updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_redirect(socket, :new, contractor_opportunity_params) do
    case ContractorOpportunities.create_contractor_opportunity(contractor_opportunity_params) do
      {:ok, _contractor_opportunity} ->
        {:noreply,
         socket
         |> put_flash(:info, "Contractor opportunity created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def save_no_redirect(socket, :edit, contractor_opportunity_params) do
    case ContractorOpportunities.update_contractor_opportunity(
           socket.assigns.contractor_opportunity,
           contractor_opportunity_params
         ) do
      {:ok, _contractor_opportunity} ->
        {:noreply,
         socket
         |> put_flash(:info, "Contractor opportunity updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_no_redirect(socket, :new, contractor_opportunity_params) do
    case ContractorOpportunities.create_contractor_opportunity(contractor_opportunity_params) do
      {:ok, _contractor_opportunity} ->
        changeset =
          ContractorOpportunities.change_contractor_opportunity(
            %BandwidthHero.ContractorOpportunities.ContractorOpportunity{}
          )

        {:noreply,
         socket
         |> put_flash(:info, "Contractor opportunity created successfully")
         |> assign(:changeset, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
