defmodule BandwidthHeroWeb.ProfileLive.Show do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.Contractors.Contractor
  alias BandwidthHero.Sourcers.Sourcer

  @impl true
  def mount(_params, _session, socket) do
    user =
      socket.assigns.current_user
      |> BandwidthHero.Repo.preload([:contractor, sourcer_users: :sourcer])

    case user do
      %{contractor: %Contractor{} = contractor} ->
        {:ok, socket |> push_redirect(to: Routes.contractor_show_path(socket, :show, contractor))}

      %{sourcer_users: [%{sourcer: %Sourcer{} = sourcer}]} ->
        {:ok, socket |> push_redirect(to: Routes.sourcer_show_path(socket, :show, sourcer))}

      _ ->
        {:ok,
         socket
         |> assign(:page_title, page_title(socket.assigns.live_action))
         |> assign(:contractor_action, contractor_action(socket))
         |> assign(:live_action, socket.assigns.live_action)
         |> assign(:contractor, nil)
         |> assign(:sourcer, nil)
         |> assign(:return_to, Routes.profile_show_path(socket, :show))}
    end
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, socket |> assign(:contractor_action, contractor_action(socket))}
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  defp page_title(:show), do: "Profile"
  defp page_title(:new_contractor), do: "New Contractor Profile"
  defp page_title(:new_sourcer), do: "New Sourcer Profile"

  def contractor_action(%{assigns: %{live_action: :new_contractor}}), do: :new
  def contractor_action(_), do: :show
end
