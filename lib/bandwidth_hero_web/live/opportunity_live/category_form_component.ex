defmodule BandwidthHeroWeb.OpportunityLive.CategoryFormComponent do
  use BandwidthHeroWeb, :live_component

  import BandwidthHeroWeb.OpportunityLive.FormHandlers
  alias BandwidthHero.Opportunities
  alias BandwidthHero.Fields

  @impl true
  def update(assigns, socket) do
    assigns
    |> update_socket(socket)
  end

  @impl true
  def handle_event("validate", %{"opportunity" => params}, socket) do
    socket.assigns.opportunity
    |> Opportunities.update_opportunity(params)
    |> case do
      {:ok, opportunity} ->
        send(self(), %{event: "update", payload: opportunity})
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
