defmodule BandwidthHeroWeb.SourcerUserLive.Components do
  use Phoenix.Component
  use PetalComponents
  alias BandwidthHeroWeb.Endpoint
  alias BandwidthHeroWeb.Router.Helpers, as: Routes

  def sourcer_user_table(assigns) do
    ~H"""
    <.table class={@class}>
      <.tr>
        <.th>Position</.th>

        <.th></.th>
      </.tr>
      <%= for sourcer_user <- @sourcer_users do %>
        <.tr id={"sourcer_user-#{sourcer_user.id}"}>
          <.td><%= sourcer_user.position %></.td>

          <.td>
            <span>
              <.a
                link_type="live_redirect"
                label="Show"
                to={Routes.sourcer_user_show_path(Endpoint, :show, sourcer_user)}
              />
            </span>
            <span>
              <.a
                link_type="live_patch"
                label="Edit"
                to={Routes.sourcer_user_index_path(Endpoint, :edit, sourcer_user)}
              />
            </span>
            <span>
              <.a
                label="Delete"
                to="#"
                phx-click="delete"
                phx-value-id={sourcer_user.id}
                data={[confirm: "Are you sure?"]}
              />
            </span>
          </.td>
        </.tr>
      <% end %>
    </.table>
    """
  end

  def sourcer_user_card(assigns) do
    ~H"""
    <.card variant="outline">
      <.card_content category="Sourcer user">
        <ul>
          <li>
            <strong>Position:</strong>
            <%= @sourcer_user.position %>
          </li>
        </ul>
      </.card_content>
    </.card>
    """
  end
end
