defmodule BandwidthHeroWeb.ContractorErpTagLive.FormComponent do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.Tags
  alias BandwidthHero.Tags.ErpTag
  import BandwidthHeroWeb.ContractorErpTagLive.FormHandlers

  @impl true
  def update(%{contractor_erp_tag: %{erp_tag: erp_tag}} = assigns, socket) do
    contractor_id = Map.get(assigns, :contractor_id, nil)
    erp_tag_type = Map.get(assigns, :erp_tag_type, nil)
    erp_tag_type = is_binary(erp_tag_type) && String.to_atom(erp_tag_type)

    erp_tags = Map.get(assigns, :erp_tags, Tags.list_erp_tags())

    erp_tags =
      if erp_tag_type,
        do: erp_tags |> Enum.filter(&(&1.type == erp_tag_type)),
        else: erp_tags

    select_list = erp_tags |> Enum.map(&{&1.label, &1.id})
    select_list = select_list ++ [{"None", nil}]

    %type{} = erp_tag

    select_list =
      if type == ErpTag,
        do: select_list ++ [{erp_tag.label, erp_tag.id}],
        else: select_list

    assigns
    |> Map.put(:contractor_id, contractor_id)
    |> Map.put(:erp_tag_select_options, select_list)
    |> update_socket(socket)
  end

  @impl true
  def handle_event("validate", %{"contractor_erp_tag" => contractor_erp_tag_params}, socket) do
    validate(contractor_erp_tag_params, socket)
  end

  def handle_event("save", %{"contractor_erp_tag" => contractor_erp_tag_params}, socket) do
    save_redirect(socket, socket.assigns.action, contractor_erp_tag_params)
  end
end
