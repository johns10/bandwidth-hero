defmodule BandwidthHeroWeb.OpportunityErpTagLive.Components do
  use Phoenix.Component
  use PetalComponents
  alias BandwidthHeroWeb.Endpoint
  alias BandwidthHeroWeb.Router.Helpers, as: Routes

  def opportunity_erp_tag_table(assigns) do
    ~H"""
    <.table class={@class}>
      <.tr>
        <.th>Years</.th>
        <.th>Projects</.th>

        <.th></.th>
      </.tr>
      <%= for opportunity_erp_tag <- @opportunity_erp_tags do %>
        <.tr id={"opportunity_erp_tag-#{opportunity_erp_tag.id}"}>
          <.td><%= opportunity_erp_tag.years %></.td>
          <.td><%= opportunity_erp_tag.projects %></.td>

          <.td>
            <span><.a link_type="live_redirect" label={"Show"} to={Routes.opportunity_erp_tag_show_path(Endpoint, :show, opportunity_erp_tag)} /></span>
            <span><.a link_type="live_patch" label={"Edit"} to={Routes.opportunity_erp_tag_index_path(Endpoint, :edit, opportunity_erp_tag)} /></span>
            <span><.a label= "Delete" to="#" phx-click="delete" phx-value-id={opportunity_erp_tag.id} data={[confirm: "Are you sure?"]}  /></span>
          </.td>
        </.tr>
      <% end %>
    </.table>
    """
  end

  def opportunity_erp_tag_card(assigns) do
    ~H"""
    <.card variant="outline">
      <.card_content category="Opportunity erp tag">
        <ul>
        
          <li>
            <strong>Years:</strong>
            <%= @opportunity_erp_tag.years %>
          </li>
        
          <li>
            <strong>Projects:</strong>
            <%= @opportunity_erp_tag.projects %>
          </li>
        
        </ul>
      </.card_content>
    </.card>
    """
  end
end
