defmodule BandwidthHeroWeb.OpportunityLive.Components do
  use Phoenix.Component
  use PetalComponents
  alias BandwidthHeroWeb.Endpoint
  alias BandwidthHeroWeb.Router.Helpers, as: Routes

  def opportunity_table(assigns) do
    ~H"""
    <.table class={@class}>
      <.tr>
        <.th>Name</.th>
        <.th>Description</.th>
        <.th>From date</.th>
        <.th>To date</.th>
        <.th>Rate</.th>
        <.th>Hours</.th>
        <.th>Travel</.th>
        <.th>Contract type</.th>
        <.th>Laptop</.th>

        <.th></.th>
      </.tr>
      <%= for opportunity <- @opportunities do %>
        <.tr id={"opportunity-#{opportunity.id}"}>
          <.td><%= opportunity.name %></.td>
          <.td><%= opportunity.description %></.td>
          <.td><%= opportunity.from_date %></.td>
          <.td><%= opportunity.to_date %></.td>
          <.td><%= opportunity.rate %></.td>
          <.td><%= opportunity.hours %></.td>
          <.td><%= opportunity.travel %></.td>
          <.td><%= opportunity.contract_type %></.td>
          <.td><%= opportunity.laptop %></.td>

          <.td>
            <span><.a link_type="live_redirect" label={"Show"} to={Routes.opportunity_show_path(Endpoint, :show, opportunity)} /></span>
            <span><.a link_type="live_patch" label={"Edit"} to={Routes.opportunity_index_path(Endpoint, :edit, opportunity)} /></span>
            <span><.a label= "Delete" to="#" phx-click="delete" phx-value-id={opportunity.id} data={[confirm: "Are you sure?"]}  /></span>
          </.td>
        </.tr>
      <% end %>
    </.table>
    """
  end

  def opportunity_card(assigns) do
    ~H"""
    <.card variant="outline">
      <.card_content category="Opportunity">
        <ul>
        
          <li>
            <strong>Name:</strong>
            <%= @opportunity.name %>
          </li>
        
          <li>
            <strong>Description:</strong>
            <%= @opportunity.description %>
          </li>
        
          <li>
            <strong>From date:</strong>
            <%= @opportunity.from_date %>
          </li>
        
          <li>
            <strong>To date:</strong>
            <%= @opportunity.to_date %>
          </li>
        
          <li>
            <strong>Rate:</strong>
            <%= @opportunity.rate %>
          </li>
        
          <li>
            <strong>Hours:</strong>
            <%= @opportunity.hours %>
          </li>
        
          <li>
            <strong>Travel:</strong>
            <%= @opportunity.travel %>
          </li>
        
          <li>
            <strong>Contract type:</strong>
            <%= @opportunity.contract_type %>
          </li>
        
          <li>
            <strong>Laptop:</strong>
            <%= @opportunity.laptop %>
          </li>
        
        </ul>
      </.card_content>
    </.card>
    """
  end
end
