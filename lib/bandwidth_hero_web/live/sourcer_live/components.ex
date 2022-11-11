defmodule BandwidthHeroWeb.SourcerLive.Components do
  use Phoenix.Component
  use PetalComponents
  alias BandwidthHeroWeb.Endpoint
  alias BandwidthHeroWeb.Router.Helpers, as: Routes

  def sourcer_table(assigns) do
    ~H"""
    <.table class={@class}>
      <.tr>
        <.th>Name</.th>
        <.th>Description</.th>
        <.th>Type</.th>
        <.th>Website</.th>

        <.th></.th>
      </.tr>
      <%= for sourcer <- @sourcers do %>
        <.tr id={"sourcer-#{sourcer.id}"}>
          <.td><%= sourcer.name %></.td>
          <.td><%= sourcer.description %></.td>
          <.td><%= sourcer.type %></.td>
          <.td><%= sourcer.website %></.td>

          <.td>
            <span>
              <.a
                link_type="live_redirect"
                label="Show"
                to={Routes.sourcer_show_path(Endpoint, :show, sourcer)}
              />
            </span>
            <span>
              <.a
                link_type="live_patch"
                label="Edit"
                to={Routes.sourcer_index_path(Endpoint, :edit, sourcer)}
              />
            </span>
            <span>
              <.a
                label="Delete"
                to="#"
                phx-click="delete"
                phx-value-id={sourcer.id}
                data={[confirm: "Are you sure?"]}
              />
            </span>
          </.td>
        </.tr>
      <% end %>
    </.table>
    """
  end

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

        <.th></.th>
      </.tr>
      <%= for opportunity <- @opportunities do %>
        <.tr id={"opportunity-#{opportunity.id}"}>
          <.td><%= opportunity.name %></.td>
          <.td><%= opportunity.description %></.td>
          <.td><%= opportunity.from_date %></.td>
          <.td><%= opportunity.to_date %></.td>
          <.td><%= opportunity.rate %></.td>
          <.td><%= opportunity.hours_per_week %></.td>

          <.td>
            <span>
              <.a
                link_type="live_redirect"
                label="Show"
                to={Routes.opportunity_show_path(Endpoint, :show, opportunity)}
              />
            </span>
            <span>
              <.a
                link_type="live_patch"
                label="Edit"
                to={
                  Routes.sourcer_show_path(
                    Endpoint,
                    :edit_opportunity,
                    opportunity.sourcer_id,
                    opportunity
                  )
                }
              />
            </span>
            <span>
              <.a
                label="Delete"
                to="#"
                phx-click="delete_opportunity"
                phx-value-id={opportunity.id}
                data={[confirm: "Are you sure?"]}
              />
            </span>
          </.td>
        </.tr>
      <% end %>
    </.table>
    """
  end

  def sourcer_card(assigns) do
    assigns =
      assigns
      |> Map.put(:class, Map.get(assigns, :class, ""))

    ~H"""
    <.card variant="outline" class={@class}>
      <.card_content category="Sourcer">
        <ul>
          <li>
            <strong>Name:</strong>
            <%= @sourcer.name %>
          </li>

          <li>
            <strong>Description:</strong>
            <%= @sourcer.description %>
          </li>

          <li>
            <strong>Type:</strong>
            <%= @sourcer.type %>
          </li>

          <li>
            <strong>Website:</strong>
            <%= @sourcer.website %>
          </li>
        </ul>
      </.card_content>
    </.card>
    """
  end
end
