defmodule BandwidthHeroWeb.CertificateLive.Components do
  use Phoenix.Component
  use PetalComponents
  alias BandwidthHeroWeb.Endpoint
  alias BandwidthHeroWeb.Router.Helpers, as: Routes

  def certificate_table(assigns) do
    ~H"""
    <.table class="@class">
      <.tr>
        <.th>Label</.th>
        <.th>Description</.th>

        <.th></.th>
      </.tr>
      <%= for certificate <- @certificate_collection do %>
        <.tr id={"certificate-#{certificate.id}"}>
          <.td><%= certificate.label %></.td>
          <.td><%= certificate.description %></.td>

          <.td>
            <span><.a link_type="live_redirect" label={"Show"} to={Routes.certificate_show_path(Endpoint, :show, certificate)} /></span>
            <span><.a link_type="live_patch" label={"Edit"} to={Routes.certificate_index_path(Endpoint, :edit, certificate)} /></span>
            <span><.a label= "Delete" to="#" phx-click="delete" phx-value-id={certificate.id} data={[confirm: "Are you sure?"]}  /></span>
          </.td>
        </.tr>
      <% end %>
    </.table>
    """
  end
end
