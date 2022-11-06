defmodule BandwidthHeroWeb.ErpTagLive.FormComponent do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.Tags
  alias BandwidthHero.Utils
  import BandwidthHeroWeb.ErpTagLive.FormHandlers

  @impl true
  def update(assigns, socket) do
    tag_options = Tags.list_erp_tags() |> Utils.to_select_options()

    assigns
    |> Map.put(:tag_options, tag_options)
    |> update_socket(socket)
  end

  @impl true
  def handle_event("validate", %{"erp_tag" => erp_tag_params}, socket) do
    validate(erp_tag_params, socket)
  end

  def handle_event("save", %{"erp_tag" => erp_tag_params}, socket) do
    save_redirect(socket, socket.assigns.action, erp_tag_params)
  end
end
