defmodule BandwidthHeroWeb.ErpTagLive.Components do
  use Phoenix.Component
  use PetalComponents
  alias BandwidthHeroWeb.Endpoint
  alias BandwidthHeroWeb.Router.Helpers, as: Routes

  def erp_tag_table(assigns) do
    ~H"""
    <.table class="@class">
      <.tr>
        <.th>Label</.th>
        <.th>Type</.th>

        <.th></.th>
      </.tr>
      <%= for erp_tag <- @erp_tags do %>
        <.tr id={"erp_tag-#{erp_tag.id}"}>
          <.td><%= erp_tag.label %></.td>

          <.td>
            <span>
              <.a
                link_type="live_redirect"
                label="Show"
                to={Routes.erp_tag_show_path(Endpoint, :show, erp_tag)}
              />
            </span>
            <span>
              <.a
                link_type="live_patch"
                label="Edit"
                to={Routes.erp_tag_index_path(Endpoint, :edit, erp_tag)}
              />
            </span>
            <span>
              <.a
                label="Delete"
                to="#"
                phx-click="delete"
                phx-value-id={erp_tag.id}
                data={[confirm: "Are you sure?"]}
              />
            </span>
          </.td>
        </.tr>
      <% end %>
    </.table>
    """
  end

  def erp_tag_card(assigns) do
    ~H"""
    <.card variant="outline">
      <.card_content category="Erp tag">
        <ul>
          <li>
            <strong>Label:</strong>
            <%= @erp_tag.label %>
          </li>
        </ul>
      </.card_content>
    </.card>
    """
  end
end
