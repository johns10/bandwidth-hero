defmodule BandwidthHeroWeb.OpportunityLive.FormHandlers do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.Opportunities
  alias BandwidthHero.Opportunities.Opportunity

  @impl true
  def update_socket(%{opportunity: opportunity} = assigns, socket) do
    changeset = Opportunities.change_opportunity(opportunity)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def validate(params, socket) do
    changeset =
      socket.assigns.opportunity
      |> Opportunities.change_opportunity(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def save_redirect(socket, :edit, opportunity_params) do
    case Opportunities.update_opportunity(socket.assigns.opportunity, opportunity_params) do
      {:ok, _opportunity} ->
        {:noreply,
         socket
         |> put_flash(:info, "Opportunity updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_redirect(socket, :new, opportunity_params) do
    case Opportunities.create_opportunity(opportunity_params) do
      {:ok, _opportunity} ->
        {:noreply,
         socket
         |> put_flash(:info, "Opportunity created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def save_no_redirect(socket, :edit, opportunity_params) do
    case Opportunities.update_opportunity(socket.assigns.opportunity, opportunity_params) do
      {:ok, _opportunity} ->
        {:noreply,
         socket
         |> put_flash(:info, "Opportunity updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_no_redirect(socket, :new, opportunity_params) do
    case Opportunities.create_opportunity(opportunity_params) do
      {:ok, _opportunity} ->
        changeset = Opportunities.change_opportunity(%BandwidthHero.Opportunities.Opportunity{})
        {:noreply,
         socket
         |> put_flash(:info, "Opportunity created successfully")
         |> assign(:changeset, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
