defmodule BandwidthHeroWeb.AvailabilityLive.Components do
  use Phoenix.Component
  use PetalComponents
  alias BandwidthHeroWeb.Endpoint
  alias BandwidthHeroWeb.Router.Helpers, as: Routes

  def availability_table(assigns) do
    ~H"""
    <.table class={@class}>
      <.tr>
        <.th>From</.th>
        <.th>To</.th>

        <.th></.th>
      </.tr>
      <%= for availability <- @availabilities do %>
        <.tr id={"availability-#{availability.id}"}>
          <.td><%= availability.available_from %></.td>
          <.td><%= availability.available_to %></.td>

          <.td>
            <span>
              <.a
                link_type="live_redirect"
                label="Show"
                to={Routes.availability_show_path(Endpoint, :show, availability)}
              />
            </span>
            <span>
              <.a
                link_type="live_patch"
                label="Edit"
                to={Routes.availability_index_path(Endpoint, :edit, availability)}
              />
            </span>
            <span>
              <.a
                label="Delete"
                to="#"
                phx-click="delete"
                phx-value-id={availability.id}
                data={[confirm: "Are you sure?"]}
              />
            </span>
          </.td>
        </.tr>
      <% end %>
    </.table>
    """
  end

  def availability_card(assigns) do
    ~H"""
    <.card variant="outline">
      <.card_content category="Availability">
        <ul>
          <li>
            <strong>From:</strong>
            <%= @availability.available_from %>
          </li>

          <li>
            <strong>To:</strong>
            <%= @availability.available_to %>
          </li>

          <li>
            <strong>Hours:</strong>
            <%= @availability.hours %>
          </li>
        </ul>
      </.card_content>
    </.card>
    """
  end
end
