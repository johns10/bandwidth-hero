defmodule BandwidthHeroWeb.ContractorOpportunityLive.Components do
  use Phoenix.Component
  use PetalComponents
  alias BandwidthHeroWeb.Endpoint
  alias BandwidthHeroWeb.Router.Helpers, as: Routes

  def contractor_opportunity_table(assigns) do
    ~H"""
    <.table class={@class}>
      <.tr>
        <.th>Subject</.th>
        <.th>Message</.th>

        <.th></.th>
      </.tr>
      <%= for contractor_opportunity <- @contractor_opportunities do %>
        <.tr id={"contractor_opportunity-#{contractor_opportunity.id}"}>
          <.td><%= contractor_opportunity.subject %></.td>
          <.td><%= contractor_opportunity.message %></.td>

          <.td>
            <span><.a link_type="live_redirect" label={"Show"} to={Routes.contractor_opportunity_show_path(Endpoint, :show, contractor_opportunity)} /></span>
            <span><.a link_type="live_patch" label={"Edit"} to={Routes.contractor_opportunity_index_path(Endpoint, :edit, contractor_opportunity)} /></span>
            <span><.a label= "Delete" to="#" phx-click="delete" phx-value-id={contractor_opportunity.id} data={[confirm: "Are you sure?"]}  /></span>
          </.td>
        </.tr>
      <% end %>
    </.table>
    """
  end

  def contractor_opportunity_card(assigns) do
    ~H"""
    <.card variant="outline">
      <.card_content category="Contractor opportunity">
        <ul>
        
          <li>
            <strong>Subject:</strong>
            <%= @contractor_opportunity.subject %>
          </li>
        
          <li>
            <strong>Message:</strong>
            <%= @contractor_opportunity.message %>
          </li>
        
        </ul>
      </.card_content>
    </.card>
    """
  end
end
