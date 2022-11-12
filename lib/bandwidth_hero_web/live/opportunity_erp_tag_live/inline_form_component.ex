defmodule BandwidthHeroWeb.OpportunityErpTagLive.InlineFormComponent do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.OpportunityErpTags
  import BandwidthHeroWeb.OpportunityErpTagLive.FormHandlers

  @impl true
  def update(%{opportunity_erp_tag: %{id: nil}} = assigns, socket) do
    assigns
    |> Map.put(:action, :new)
    |> update_socket(socket)
  end

  def update(assigns, socket) do
    assigns
    |> Map.put(:action, :edit)
    |> update_socket(socket)
  end

  @impl true
  def handle_event("save", %{"opportunity_erp_tag" => opportunity_erp_tag_params}, socket) do
    handle_existence(opportunity_erp_tag_params, socket)
  end

  def handle_existence(%{"exists" => "true"} = params, %{assigns: %{action: :new}} = socket) do
    case OpportunityErpTags.create_opportunity_erp_tag(params) do
      {:ok, opportunity_erp_tag} ->
        send(self(), %{event: "create", payload: opportunity_erp_tag})
        {:noreply, socket}

      {:error, _} ->
        IO.puts("Failed to create opportunity_erp_tag in #{__MODULE__}")
        {:noreply, socket}
    end
  end

  def handle_existence(
        %{"exists" => "false"},
        %{assigns: %{action: :edit, opportunity_erp_tag: tag}} = socket
      ) do
    case OpportunityErpTags.delete_opportunity_erp_tag(tag) do
      {:ok, opportunity_erp_tag} ->
        send(self(), %{event: "delete", payload: opportunity_erp_tag})
        {:noreply, socket}

      {:error, _} ->
        IO.puts("Failed to delete opportunity_erp_tag in #{__MODULE__}")
        {:noreply, socket}
    end
  end

  def handle_existence(%{"exists" => "true"} = params, %{assigns: %{action: :edit}} = socket) do
    save_no_redirect(socket, :edit, params)
  end
end
