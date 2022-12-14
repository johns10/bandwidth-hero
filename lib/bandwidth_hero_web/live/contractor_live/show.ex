defmodule BandwidthHeroWeb.ContractorLive.Show do
  use BandwidthHeroWeb, :live_view
  on_mount BandwidthHeroWeb.UserLiveAuth

  alias BandwidthHero.Contractors
  alias BandwidthHero.ContractorErpTags
  alias BandwidthHero.ContractorErpTags.ContractorErpTag
  import BandwidthHeroWeb.ContractorLive.Components
  import BandwidthHeroWeb.ContractorLive.Utils

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id} = attrs, _, socket) do
    contractor = get_contractor(id)
    contractor_erp_tag_id = Map.get(attrs, "erp_tag_id", nil)

    contractor_erp_tag =
      if contractor_erp_tag_id do
        ContractorErpTags.get_contractor_erp_tag!(contractor_erp_tag_id, preloads: [erp_tag: true])
      else
        %ContractorErpTag{}
      end

    erp_tag_type = Map.get(attrs, "erp_tag_type", nil)
    availability_id = Map.get(attrs, "availability_id", nil)

    availability_action =
      case socket.assigns.live_action do
        :new_availability -> :new
        :edit_availability -> :edit
        _ -> :show
      end

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:contractor, contractor)
     |> assign(:availability_action, availability_action)
     |> assign(:return_to, Routes.contractor_show_path(socket, :show, contractor))
     |> assign(:contractor_erp_tag, contractor_erp_tag)
     |> assign(:erp_tag_type, erp_tag_type)
     |> assign(:availability_id, availability_id)
     |> assign(:can_update, can_update_contractor?(socket.assigns.current_user, contractor))}
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    contractor = Contractors.get_contractor!(id)
    {:ok, _} = Contractors.delete_contractor(contractor)

    {:noreply, socket |> push_redirect(to: Routes.profile_show_path(socket, :show))}
  end

  def handle_event("delete-contractor-erp-tag", %{"id" => id}, socket) do
    contractor_erp_tag = ContractorErpTags.get_contractor_erp_tag!(id)
    {:ok, _} = ContractorErpTags.delete_contractor_erp_tag(contractor_erp_tag)

    {:noreply, assign(socket, :contractor, get_contractor(id))}
  end

  @impl true
  def handle_info(%{event: event, payload: %ContractorErpTag{}}, socket)
      when event in ["create", "delete", "update"] do
    {:noreply, assign(socket, :contractor, get_contractor(socket.assigns.contractor.id))}
  end

  defp get_contractor(id) do
    Contractors.get_contractor!(id, preloads: [contractor_erp_tags: true, availabilities: true])
  end

  defp page_title(:show), do: "Show Contractor"
  defp page_title(:edit), do: "Edit Contractor"
  defp page_title(:edit_erp_tag), do: "Show Contractor"
  defp page_title(:new_erp_tag), do: "Show Contractor"
  defp page_title(:edit_availability), do: "Show Contractor"
  defp page_title(:new_availability), do: "Show Contractor"
end
