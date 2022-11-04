defmodule BandwidthHeroWeb.ContractorLive.ErpTagsComponent do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.Contractors
  alias BandwidthHero.ContractorErpTags
  alias BandwidthHero.Tags
  alias BandwidthHero.Utils
  alias BandwidthHeroWeb.Endpoint
  import BandwidthHeroWeb.ContractorLive.FormHandlers

  @impl true
  def update(%{contractor: %{contractor_erp_tags: contractor_erp_tags} = contractor} = assigns, socket) do
    all_tags = list_erp_tags()
    selected_tag_ids = contractor_erp_tags |> Enum.map(& &1.erp_tag.id)
    {:ok, socket
    |> assign(:return_to, Routes.contractor_index_path(socket, :index))
    |> assign(:contractor, contractor)
    |> assign(:contractor_erp_tags, contractor_erp_tags)
    |> assign(:unselected_erp_tags, all_tags |> Enum.filter(& &1.id not in selected_tag_ids))
    |> assign(assigns)}
  end

  def handle_event("delete-contractor-erp-tag", %{"id" => id}, socket) do
    contractor_erp_tag = ContractorErpTags.get_contractor_erp_tag!(id)
    {:ok, _} = ContractorErpTags.delete_contractor_erp_tag(contractor_erp_tag)

    {:noreply, assign(:tags, list_erp_tags())}
  end

  def list_erp_tags() do
    Tags.list_erp_tags()
  end

  def tag_component(assigns) do
    ~H"""
      <div
        class="text-xs inline-flex items-center font-bold leading-sm uppercase mr-2 my-2 px-2 py-1 bg-black dark:bg-gray-400 text-black rounded-full flex-shrink"
      >
      <.a to="#" phx-click="delete-contractor-erp-tag" phx-value-id={@tag.id}>
        <Heroicons.x_mark solid class="w-4 h-4 mr-1 text-red-800" />
      </.a>
      <div>
        <%= @tag.erp_tag.label %> <%= @tag.years %>y <%= @tag.projects %>p
      </div>
      <.a
        link_type="live_patch"
        to={Routes.contractor_show_path(Endpoint, :edit_erp_tag, @contractor.id, @tag.id, erp_tag_type: @tag.erp_tag.type)}
      >
        <Heroicons.pencil solid class="w-4 h-4 ml-1 text-black" />
      </.a>
    </div>
    """
  end

  def to_select_options(tags, existing_tag_ids, type) do
    tags
    |> Enum.filter(& &1.type == type)
    |> Enum.filter(& &1.id not in existing_tag_ids)
    |> Enum.map(& {&1.label, &1.id})
  end
end
