defmodule BandwidthHeroWeb.ContractorErpTagLive.Components do
  use Phoenix.Component
  use PetalComponents
  alias BandwidthHeroWeb.Endpoint
  alias BandwidthHeroWeb.Router.Helpers, as: Routes

  def contractor_erp_tag_table(assigns) do
    ~H"""
    <.table class="@class">
      <.tr>
        <.th>Years</.th>
        <.th>Projects</.th>

        <.th></.th>
      </.tr>
      <%= for contractor_erp_tag <- @contractor_erp_tag_collection do %>
        <.tr id={"contractor_erp_tag-#{contractor_erp_tag.id}"}>
          <.td><%= contractor_erp_tag.years %></.td>
          <.td><%= contractor_erp_tag.projects %></.td>

          <.td>
            <span><.a link_type="live_redirect" label={"Show"} to={Routes.contractor_erp_tag_show_path(Endpoint, :show, contractor_erp_tag)} /></span>
            <span><.a link_type="live_patch" label={"Edit"} to={Routes.contractor_erp_tag_index_path(Endpoint, :edit, contractor_erp_tag)} /></span>
            <span><.a label= "Delete" to="#" phx-click="delete" phx-value-id={contractor_erp_tag.id} data={[confirm: "Are you sure?"]}  /></span>
          </.td>
        </.tr>
      <% end %>
    </.table>
    """
  end

  def contractor_erp_tag_card(assigns) do
    ~H"""
    <.card variant="outline">
      <.card_content category="Contractor erp tag">
        <ul>
        
          <li>
            <strong>Years:</strong>
            <%= @contractor_erp_tag.years %>
          </li>
        
          <li>
            <strong>Projects:</strong>
            <%= @contractor_erp_tag.projects %>
          </li>
        
        </ul>
      </.card_content>
    </.card>
    """
  end
end
