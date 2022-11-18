defmodule BandwidthHeroWeb.SourcerLiveTest do
  use BandwidthHeroWeb.ConnCase

  import Phoenix.LiveViewTest
  import BandwidthHero.SourcersFixtures
  import BandwidthHero.SourcerUsersFixtures

  @create_attrs %{
    description: "some description",
    name: "some name",
    type: :end_customer,
    website: "some website"
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name",
    type: :recruiter,
    website: "some updated website"
  }
  @invalid_attrs %{description: nil, name: nil, type: nil, website: nil}

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

    test "lists all sourcers", %{conn: conn, sourcer: sourcer} do
      {:ok, _index_live, html} = live(conn, Routes.sourcer_index_path(conn, :index))

      assert html =~ "Listing Sourcers"
      assert html =~ sourcer.description
    end

    test "saves new sourcer", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.sourcer_index_path(conn, :index))

      assert index_live |> element("a", "New Sourcer") |> render_click() =~
               "New Sourcer"

      assert_patch(index_live, Routes.sourcer_index_path(conn, :new))

      assert index_live
             |> form("#sourcer-form", sourcer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#sourcer-form", sourcer: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.sourcer_index_path(conn, :index))

      assert html =~ "Sourcer created successfully"
      assert html =~ "some description"
    end

    test "updates sourcer in listing", %{conn: conn, sourcer: sourcer} do
      {:ok, index_live, _html} = live(conn, Routes.sourcer_index_path(conn, :index))

      assert index_live |> element("#sourcer-#{sourcer.id} a", "Edit") |> render_click() =~
               "Edit Sourcer"

      assert_patch(index_live, Routes.sourcer_index_path(conn, :edit, sourcer))

      assert index_live
             |> form("#sourcer-form", sourcer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#sourcer-form", sourcer: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.sourcer_index_path(conn, :index))

      assert html =~ "Sourcer updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes sourcer in listing", %{conn: conn, sourcer: sourcer} do
      {:ok, index_live, _html} = live(conn, Routes.sourcer_index_path(conn, :index))

      assert index_live |> element("#sourcer-#{sourcer.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#sourcer-#{sourcer.id}")
    end
  end

  describe "Show" do
    setup [:register_and_log_in_user, :create_sourcer, :create_sourcer_user]

    test "displays sourcer", %{conn: conn, sourcer: sourcer} do
      {:ok, _show_live, html} = live(conn, Routes.sourcer_show_path(conn, :show, sourcer))

      assert html =~ "Show Sourcer"
      assert html =~ sourcer.description
    end

    test "updates sourcer within modal", %{conn: conn, sourcer: sourcer} do
      {:ok, show_live, _html} = live(conn, Routes.sourcer_show_path(conn, :show, sourcer))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Sourcer"

      assert_patch(show_live, Routes.sourcer_show_path(conn, :edit, sourcer))

      assert show_live
             |> form("#sourcer-form", sourcer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#sourcer-form", sourcer: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.sourcer_show_path(conn, :show, sourcer))

      assert html =~ "Sourcer updated successfully"
      assert html =~ "some updated description"
    end
  end
end
