defmodule BandwidthHeroWeb.SourcerUserLiveTest do
  use BandwidthHeroWeb.ConnCase

  import Phoenix.LiveViewTest
  import BandwidthHero.SourcerUsersFixtures
  import BandwidthHero.SourcersFixtures

  def create_attrs(%{user: user, sourcer: sourcer}),
    do: %{position: "some position", user_id: user.id, sourcer_id: sourcer.id}

  def update_attrs(%{user: user, sourcer: sourcer}),
    do: %{position: "some updated position", user_id: user.id, sourcer_id: sourcer.id}

  @invalid_attrs %{position: nil, user_id: nil}

  defp create_sourcer(_) do
    sourcer = sourcer_fixture()
    %{sourcer: sourcer}
  end

  defp create_sourcer_user(%{user: user, sourcer: sourcer}) do
    sourcer_user = sourcer_user_fixture(%{user_id: user.id, sourcer_id: sourcer.id})
    %{sourcer_user: sourcer_user}
  end

  describe "Index" do
    setup [:register_and_log_in_user, :create_sourcer, :create_sourcer_user]

    test "lists all sourcer_users", %{conn: conn, sourcer_user: sourcer_user} do
      {:ok, _index_live, html} = live(conn, Routes.sourcer_user_index_path(conn, :index))

      assert html =~ "Listing Sourcer users"
      assert html =~ sourcer_user.position
    end

    test "saves new sourcer_user", %{conn: conn} = context do
      {:ok, index_live, _html} = live(conn, Routes.sourcer_user_index_path(conn, :index))

      assert index_live |> element("a", "New Sourcer user") |> render_click() =~
               "New Sourcer user"

      assert_patch(index_live, Routes.sourcer_user_index_path(conn, :new))

      assert index_live
             |> form("#sourcer_user-form", sourcer_user: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#sourcer_user-form", sourcer_user: create_attrs(context))
        |> render_submit()
        |> follow_redirect(conn, Routes.sourcer_user_index_path(conn, :index))

      assert html =~ "Sourcer user created successfully"
      assert html =~ "some position"
    end

    test "updates sourcer_user in listing", context do
      %{conn: conn, sourcer_user: sourcer_user} = context
      {:ok, index_live, _html} = live(conn, Routes.sourcer_user_index_path(conn, :index))

      assert index_live |> element("#sourcer_user-#{sourcer_user.id} a", "Edit") |> render_click() =~
               "Edit Sourcer user"

      assert_patch(index_live, Routes.sourcer_user_index_path(conn, :edit, sourcer_user))

      assert index_live
             |> form("#sourcer_user-form", sourcer_user: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#sourcer_user-form", sourcer_user: update_attrs(context))
        |> render_submit()
        |> follow_redirect(conn, Routes.sourcer_user_index_path(conn, :index))

      assert html =~ "Sourcer user updated successfully"
      assert html =~ "some updated position"
    end

    test "deletes sourcer_user in listing", %{conn: conn, sourcer_user: sourcer_user} do
      {:ok, index_live, _html} = live(conn, Routes.sourcer_user_index_path(conn, :index))

      assert index_live
             |> element("#sourcer_user-#{sourcer_user.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#sourcer_user-#{sourcer_user.id}")
    end
  end

  describe "Show" do
    setup [:register_and_log_in_user, :create_sourcer, :create_sourcer_user]

    test "displays sourcer_user", context do
      %{conn: conn, sourcer_user: sourcer_user} = context

      {:ok, _show_live, html} =
        live(conn, Routes.sourcer_user_show_path(conn, :show, sourcer_user))

      assert html =~ "Show Sourcer user"
      assert html =~ sourcer_user.position
    end

    test "updates sourcer_user within modal", context do
      %{conn: conn, sourcer_user: sourcer_user} = context

      {:ok, show_live, _html} =
        live(conn, Routes.sourcer_user_show_path(conn, :show, sourcer_user))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Sourcer user"

      assert_patch(show_live, Routes.sourcer_user_show_path(conn, :edit, sourcer_user))

      assert show_live
             |> form("#sourcer_user-form", sourcer_user: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#sourcer_user-form", sourcer_user: update_attrs(context))
        |> render_submit()
        |> follow_redirect(conn, Routes.sourcer_user_show_path(conn, :show, sourcer_user))

      assert html =~ "Sourcer user updated successfully"
      assert html =~ "some updated position"
    end
  end
end
