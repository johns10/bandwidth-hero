defmodule BandwidthHeroWeb.ContractorLive.ErpTagsComponent do
  use BandwidthHeroWeb, :live_component
  use Phoenix.Component

  alias BandwidthHero.ContractorErpTags.ContractorErpTag
  alias BandwidthHero.Tags
  alias BandwidthHero.Fields

  @impl true
  def update(
        %{contractor: %{contractor_erp_tags: contractor_erp_tags} = contractor} = assigns,
        socket
      ) do
    erp_tags = list_erp_tags()

    {:ok,
     socket
     |> assign(:return_to, Routes.contractor_index_path(socket, :index))
     |> assign(:contractor, contractor)
     |> assign(:contractor_erp_tags, contractor_erp_tags)
     |> assign(:erp_tags, erp_tags)
     |> assign(assigns)}
  end

  def list_erp_tags() do
    Tags.list_erp_tags()
  end

  def find_contractor_erp_tag(%{contractor_erp_tags: contractor_erp_tags}, erp_tag_id) do
    contractor_erp_tag =
      contractor_erp_tags
      |> Enum.find(&(&1.erp_tag_id == erp_tag_id))

    contractor_erp_tag || %ContractorErpTag{}
  end

  def category(assigns) do
    ~H"""
    <div class="flex flex-col p-1" x-data="{expanded: true}">
      <div class="flex items-center">
        <.a @click="expanded = ! expanded" to="#">
          <div x-show="expanded">
            <Heroicons.chevron_down solid class="w-4 h-4 m-2" />
          </div>
          <div x-show="!expanded">
            <Heroicons.chevron_right solid class="w-4 h-4 m-2" />
          </div>
        </.a>
        <%= @label %>
      </div>
      <div x-show="expanded" x-collapse.duration.1000ms class="ml-4">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end
end
