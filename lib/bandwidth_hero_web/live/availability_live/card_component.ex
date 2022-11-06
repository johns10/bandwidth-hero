defmodule BandwidthHeroWeb.AvailabilityLive.CardComponent do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.Availabilities
  alias BandwidthHero.Availabilities.Availability
  alias BandwidthHeroWeb.Endpoint

  @impl true
  def update(assigns, socket) do
    availability_id = Map.get(assigns, :availability_id, nil)
    contractor = assigns.contractor

    availability =
      if availability_id,
        do: Availabilities.get_availability!(availability_id),
        else: %Availability{}

    live_action =
      assigns.live_action
      |> case do
        :new_availability -> :new
        :edit_availability -> :edit
        action -> action
      end

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:availability, availability)
     |> assign(:contractor, contractor)
     |> assign(:live_action, live_action)
     |> assign(:return_to, Routes.contractor_show_path(socket, :show, contractor))}
  end

  def availability_table(assigns) do
    ~H"""
    <.table class={@class}>
      <.tr>
        <.th>From</.th>
        <.th>To</.th>
        <.th>Hours</.th>
        <.th></.th>
      </.tr>
      <%= for availability <- @availabilities do %>
        <.tr id={"availability-#{availability.id}"}>
          <.td><%= availability.available_from %></.td>
          <.td><%= availability.available_to %></.td>
          <.td><%= availability.hours %></.td>

          <.td>
            <span>
              <.a
                link_type="live_patch"
                label="Edit"
                to={
                  Routes.contractor_show_path(Endpoint, :edit_availability, @contractor, availability)
                }
              />
            </span>
            <span>
              <.a
                label="Delete"
                to="#"
                phx-click="delete-availability"
                phx-value-id={availability.id}
                data={[confirm: "Are you sure?"]}
              />
            </span>
          </.td>
        </.tr>
      <% end %>
    </.table>
    """
  end
end
