defmodule BandwidthHeroWeb.ErpTagLiveTest do
  use BandwidthHeroWeb.ConnCase

  import Phoenix.LiveViewTest
  import BandwidthHero.TagsFixtures

  @create_attrs %{label: "some label", type: :vendor}
  @update_attrs %{label: "some updated label", type: :platform}
  @invalid_attrs %{label: nil, type: nil}

  defp create_erp_tag(_) do
    erp_tag = erp_tag_fixture()
    %{erp_tag: erp_tag}
  end

  describe "Index" do
    setup [:register_and_log_in_user, :create_erp_tag]

    test "lists all erp_tag", %{conn: conn, erp_tag: erp_tag} do
      {:ok, _index_live, html} = live(conn, Routes.erp_tag_index_path(conn, :index))

      assert html =~ "Listing Erp tag"
      assert html =~ erp_tag.label
    end

    test "saves new erp_tag", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.erp_tag_index_path(conn, :index))

      assert index_live |> element("a", "New Erp Tag") |> render_click() =~
               "New Erp tag"

      assert_patch(index_live, Routes.erp_tag_index_path(conn, :new))

      assert index_live
             |> form("#erp_tag-form", erp_tag: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#erp_tag-form", erp_tag: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.erp_tag_index_path(conn, :index))

      assert html =~ "Erp tag created successfully"
      assert html =~ "some label"
    end

    test "updates erp_tag in listing", %{conn: conn, erp_tag: erp_tag} do
      {:ok, index_live, _html} = live(conn, Routes.erp_tag_index_path(conn, :index))

      assert index_live |> element("#erp_tag-#{erp_tag.id} a", "Edit") |> render_click() =~
               "Edit Erp tag"

      assert_patch(index_live, Routes.erp_tag_index_path(conn, :edit, erp_tag))

      assert index_live
             |> form("#erp_tag-form", erp_tag: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#erp_tag-form", erp_tag: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.erp_tag_index_path(conn, :index))

      assert html =~ "Erp tag updated successfully"
      assert html =~ "some updated label"
    end

    test "deletes erp_tag in listing", %{conn: conn, erp_tag: erp_tag} do
      {:ok, index_live, _html} = live(conn, Routes.erp_tag_index_path(conn, :index))

      assert index_live |> element("#erp_tag-#{erp_tag.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#erp_tag-#{erp_tag.id}")
    end
  end

  describe "Show" do
    setup [:register_and_log_in_user, :create_erp_tag]

    test "displays erp_tag", %{conn: conn, erp_tag: erp_tag} do
      {:ok, _show_live, html} = live(conn, Routes.erp_tag_show_path(conn, :show, erp_tag))

      assert html =~ "Show Erp tag"
      assert html =~ erp_tag.label
    end

    test "updates erp_tag within modal", %{conn: conn, erp_tag: erp_tag} do
      {:ok, show_live, _html} = live(conn, Routes.erp_tag_show_path(conn, :show, erp_tag))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Erp tag"

      assert_patch(show_live, Routes.erp_tag_show_path(conn, :edit, erp_tag))

      assert show_live
             |> form("#erp_tag-form", erp_tag: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#erp_tag-form", erp_tag: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.erp_tag_show_path(conn, :show, erp_tag))

      assert html =~ "Erp tag updated successfully"
      assert html =~ "some updated label"
    end
  end
end
