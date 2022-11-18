defmodule BandwidthHeroWeb.ContractorErpTagLive.InlineFormComponent do
  use BandwidthHeroWeb, :live_component

  import BandwidthHeroWeb.ContractorErpTagLive.FormHandlers
  alias BandwidthHero.ContractorErpTags

  @impl true
  def update(%{contractor_erp_tag: %{id: nil}} = assigns, socket) do
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
  def handle_event("save", %{"contractor_erp_tag" => params}, socket) do
    handle_existence(params, socket)
  end

  def handle_existence(%{"exists" => "true"} = params, %{assigns: %{action: :new}} = socket) do
    case ContractorErpTags.create_contractor_erp_tag(params) do
      {:ok, contractor_erp_tag} ->
        send(self(), %{event: "create", payload: contractor_erp_tag})
        {:noreply, socket}

      {:error, _} ->
        IO.puts("Failed to create contractor_erp_tag in #{__MODULE__}")
        {:noreply, socket}
    end
  end

  def handle_existence(
        %{"exists" => "false"},
        %{assigns: %{action: :edit, contractor_erp_tag: tag}} = socket
      ) do
    case ContractorErpTags.delete_contractor_erp_tag(tag) do
      {:ok, contractor_erp_tag} ->
        send(self(), %{event: "delete", payload: contractor_erp_tag})
        {:noreply, socket}

      {:error, _} ->
        IO.puts("Failed to delete contractor_erp_tag in #{__MODULE__}")
        {:noreply, socket}
    end
  end

  def handle_existence(%{"exists" => "false"}, socket), do: {:noreply, socket}

  def handle_existence(%{"exists" => "true"} = params, %{assigns: %{action: :edit}} = socket) do
    save_no_redirect(socket, :edit, params)
  end
end
