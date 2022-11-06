defmodule <%= inspect context.web_module %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %>Live.Components do
  use Phoenix.Component
  use PetalComponents
  alias <%= inspect context.web_module %>.Endpoint
  alias <%= inspect context.web_module %>.Router.Helpers, as: Routes

  def <%= schema.singular %>_table(assigns) do
    ~H"""
    <.table class={@class}>
      <.tr>
<%= for {k, _} <- schema.attrs do %>        <.th><%= Phoenix.Naming.humanize(Atom.to_string(k)) %></.th>
<% end %>
        <.th></.th>
      </.tr>
      <%%= for <%= schema.singular %> <- @<%= schema.collection %> do %>
        <.tr id={"<%= schema.singular %>-#{<%= schema.singular %>.id}"}>
<%= for {k, _} <- schema.attrs do %>          <.td><%%= <%= schema.singular %>.<%= k %> %></.td>
<% end %>
          <.td>
            <span><.a link_type="live_redirect" label={"Show"} to={Routes.<%= schema.route_helper %>_show_path(Endpoint, :show, <%= schema.singular %>)} /></span>
            <span><.a link_type="live_patch" label={"Edit"} to={Routes.<%= schema.route_helper %>_index_path(Endpoint, :edit, <%= schema.singular %>)} /></span>
            <span><.a label= "Delete" to="#" phx-click="delete" phx-value-id={<%= schema.singular %>.id} data={[confirm: "Are you sure?"]}  /></span>
          </.td>
        </.tr>
      <%% end %>
    </.table>
    """
  end

  def <%= schema.singular %>_card(assigns) do
    ~H"""
    <.card variant="outline">
      <.card_content category="<%= schema.human_singular %>">
        <ul>
        <%= for {k, _} <- schema.attrs do %>
          <li>
            <strong><%= Phoenix.Naming.humanize(Atom.to_string(k)) %>:</strong>
            <%%= @<%= schema.singular %>.<%= k %> %>
          </li>
        <% end %>
        </ul>
      </.card_content>
    </.card>
    """
  end
end
