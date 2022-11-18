defmodule BandwidthHeroWeb.SourcerLive.Show do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.Sourcers
  alias BandwidthHero.Sourcers.Sourcer
  alias BandwidthHero.Opportunities
  alias BandwidthHero.Opportunities.Opportunity
  alias BandwidthHeroWeb.SourcerLive.Utils
  import BandwidthHeroWeb.SourcerLive.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:opportunity_action, :show)
     |> assign(:modal_title, modal_title(socket.assigns.live_action))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, action, params) when action in [:show, :edit] do
    socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> maybe_get_sourcer(params)
    |> can_update_sourcer?()
    |> guard_action(action)
  end

  defp apply_action(socket, :new_opportunity, params) do
    socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:opportunity, %Opportunity{})
    |> assign(:opportunity_action, :new)
    |> maybe_get_sourcer(params)
    |> can_update_sourcer?()
  end

  defp apply_action(socket, :edit_opportunity, %{"opportunity_id" => opportunity_id} = params) do
    socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:opportunity, Opportunities.get_opportunity!(opportunity_id))
    |> assign(:opportunity_action, :edit)
    |> maybe_get_sourcer(params)
    |> can_update_sourcer?()
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  def handle_event("delete_opportunity", %{"id" => id}, socket) do
    opportunity = Opportunities.get_opportunity!(id)
    {:ok, _} = Opportunities.delete_opportunity(opportunity)
    sourcer = Sourcers.get_sourcer!(socket.assigns.sourcer.id, preloads: [opportunities: true])
    {:noreply, assign(socket, :sourcer, sourcer)}
  end

  defp maybe_get_sourcer(%{assigns: %{sourcer: %Sourcer{id: id}}} = socket, %{"id" => id}),
    do: socket

  defp maybe_get_sourcer(socket, %{"id" => id}) do
    sourcer = Sourcers.get_sourcer!(id, preloads: [opportunities: true])

    socket
    |> assign(:sourcer, sourcer)
    |> assign(:return_to, Routes.sourcer_show_path(socket, :show, sourcer))
  end

  def can_update_sourcer?(%{assigns: %{current_user: user, sourcer: sourcer}} = socket) do
    assign(socket, :can_update?, Utils.can_update_sourcer?(user, sourcer))
  end

  def guard_action(%{assigns: %{return_to: return_to, can_update?: false}} = socket, action)
      when action in [:edit, :new_opportunity, :edit_opportunity],
      do: push_patch(socket, to: return_to)

  def guard_action(socket, _), do: socket

  defp page_title(:show), do: "Show Sourcer"
  defp page_title(:edit), do: "Edit Sourcer"
  defp page_title(:new_opportunity), do: "Show Sourcer"
  defp page_title(:edit_opportunity), do: "Show Sourcer"

  defp modal_title(:new_opportunity), do: "New Opportunity"
  defp modal_title(:edit_opportunity), do: "Edit Opportunity"
  defp modal_title(_), do: ""
end
