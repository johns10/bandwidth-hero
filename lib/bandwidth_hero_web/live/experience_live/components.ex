defmodule BandwidthHeroWeb.ExperienceLive.Components do
  use Phoenix.Component
  use PetalComponents
  alias BandwidthHeroWeb.Endpoint
  alias BandwidthHeroWeb.Router.Helpers, as: Routes

  def experience_table(assigns) do
    ~H"""
    <.table class={@class}>
      <.tr>
        <.th>Label</.th>
        <.th>Description</.th>
        <.th>From</.th>
        <.th>To</.th>

        <.th></.th>
      </.tr>
      <%= for experience <- @experience_collection do %>
        <.tr id={"experience-#{experience.id}"}>
          <.td><%= experience.label %></.td>
          <.td><%= experience.description %></.td>
          <.td><%= experience.from %></.td>
          <.td><%= experience.to %></.td>

          <.td>
            <span><.a link_type="live_redirect" label={"Show"} to={Routes.experience_show_path(Endpoint, :show, experience)} /></span>
            <span><.a link_type="live_patch" label={"Edit"} to={Routes.experience_index_path(Endpoint, :edit, experience)} /></span>
            <span><.a label= "Delete" to="#" phx-click="delete" phx-value-id={experience.id} data={[confirm: "Are you sure?"]}  /></span>
          </.td>
        </.tr>
      <% end %>
    </.table>
    """
  end
end
