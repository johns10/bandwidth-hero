defmodule BandwidthHeroWeb.UserLiveAuth do
  import Phoenix.LiveView
  import Phoenix.Component

  alias BandwidthHero.Accounts.User
  alias BandwidthHero.Accounts
  alias BandwidthHero.Contractors

  def on_mount(:default, _params, session, socket) do
    socket =
      default_assigns(socket, session)
      |> put_contractor()

    if socket.assigns.current_user do
      {:cont, socket}
    else
      {:halt,
       redirect(socket, to: BandwidthHeroWeb.Router.Helpers.user_registration_path(socket, :new))}
    end
  end

  def default_assigns(socket, %{"user_token" => token, "color_scheme" => color_scheme}),
    do: default_assigns(socket, %{"token" => token, "color_scheme" => color_scheme})

  def default_assigns(socket, %{"token" => token, "color_scheme" => color_scheme}) do
    socket
    |> assign_new(:current_user, fn ->
      Accounts.get_user_by_session_token(token)
    end)
    |> assign(:color_scheme, color_scheme)
  end

  def default_assigns(socket, _) do
    socket
    |> assign(:color_scheme, nil)
    |> assign(:current_user, nil)
    |> assign(:contractor, nil)
  end

  def put_contractor(%{assigns: %{current_user: %User{} = user}} = socket) do
    assign(socket, :user_contractor, Contractors.get_contractor_by_user_id(user.id))
  end

  def put_contractor(socket), do: socket
end
