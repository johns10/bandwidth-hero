defmodule BandwidthHeroWeb.ContractorLive.Components do
  use Phoenix.Component
  use PetalComponents
  alias BandwidthHeroWeb.Endpoint
  alias BandwidthHeroWeb.Router.Helpers, as: Routes

  def contractor_table(assigns) do
    ~H"""
    <.table class="@class">
      <.tr>
        <.th>Name</.th>
        <.th>Title</.th>
        <.th>Availability</.th>
        <.th>Bandwidth</.th>
        <.th>Travel</.th>
        <.th>International travel</.th>
        <.th>Contract type</.th>
        <.th>Laptop</.th>

        <.th></.th>
      </.tr>
      <%= for contractor <- @contractors do %>
        <.tr id={"contractor-#{contractor.id}"}>
          <.td><%= contractor.name %></.td>
          <.td><%= contractor.title %></.td>
          <.td><%= contractor.availability %></.td>
          <.td><%= contractor.bandwidth %></.td>
          <.td><%= contractor.travel %></.td>
          <.td><%= contractor.international_travel %></.td>
          <.td><%= contractor.contract_type %></.td>
          <.td><%= contractor.laptop %></.td>

          <.td>
            <span>
              <.a
                link_type="live_redirect"
                label="Show"
                to={Routes.contractor_show_path(Endpoint, :show, contractor)}
              />
            </span>
            <span>
              <.a
                link_type="live_patch"
                label="Edit"
                to={Routes.contractor_index_path(Endpoint, :edit, contractor)}
              />
            </span>
            <span>
              <.a
                label="Delete"
                to="#"
                phx-click="delete"
                phx-value-id={contractor.id}
                data={[confirm: "Are you sure?"]}
              />
            </span>
          </.td>
        </.tr>
      <% end %>
    </.table>
    """
  end

  def contractor_card(assigns) do
    ~H"""
    <.card variant="outline" class={@class}>
      <div class="bg-white py-2 px-4 flex text-gray-700 bg-gray-50 dark:bg-gray-700 dark:text-gray-300">
        <div class="flex-grow flex flex-col">
          <span class="text-2xl font-bold"><%= @contractor.name %></span>
          <span class="text-sm font-light"><%= @contractor.title %></span>
        </div>
        <div class="flex flex-column">
          <.a
            to="#"
            id="delete-contractor"
            phx-click="delete"
            phx-value-id={@contractor.id}
            data={[confirm: "Are you sure you want to delete your profile?"]}
          >
            <Heroicons.trash solid class="w-4 h-4 m-2" />
          </.a>
          <.a
            link_type="live_patch"
            to={Routes.contractor_show_path(Endpoint, :edit, @contractor)}
            id="edit-contractor"
          >
            <Heroicons.pencil solid class="w-4 h-4 m-2" />
          </.a>
        </div>
      </div>

      <.card_content>
        <ul>
          <li>
            <%= @contractor.availability |> to_string() |> Recase.to_sentence() %> Availability
          </li>

          <li>
            Can work <%= @contractor.bandwidth %> hours per work
          </li>

          <li>
            <strong>Travel:</strong>
            <%= @contractor.travel %>
          </li>

          <li>
            <strong>International travel:</strong>
            <%= @contractor.international_travel |> to_string() |> Recase.to_sentence() %>
          </li>

          <li>
            <strong>Contract type:</strong>
            <%= @contractor.contract_type |> to_string() |> Recase.to_sentence() %>
          </li>

          <li>
            <strong>Laptop:</strong>
            <%= @contractor.laptop |> to_string() |> Recase.to_sentence() %>
          </li>
        </ul>
      </.card_content>
    </.card>
    """
  end
end
