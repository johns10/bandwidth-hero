defmodule BandwidthHeroWeb.OpportunityErpTagLiveTest do
  use BandwidthHeroWeb.ConnCase

  import Phoenix.LiveViewTest
  import BandwidthHero.OpportunityErpTagsFixtures

  @create_attrs %{projects: 42, years: 42}
  @update_attrs %{projects: 43, years: 43}
  @invalid_attrs %{projects: nil, years: nil}

  defp create_opportunity_erp_tag(_) do
    opportunity_erp_tag = opportunity_erp_tag_fixture()
    %{opportunity_erp_tag: opportunity_erp_tag}
  end

  describe "Index" do
    setup [:register_and_log_in_user, :create_opportunity_erp_tag]

    test "lists all opportunity_erp_tags", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.opportunity_erp_tag_index_path(conn, :index))

      assert html =~ "Listing Opportunity erp tags"
    end

    test "saves new opportunity_erp_tag", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.opportunity_erp_tag_index_path(conn, :index))

      assert index_live |> element("a", "New Opportunity erp tag") |> render_click() =~
               "New Opportunity erp tag"

      assert_patch(index_live, Routes.opportunity_erp_tag_index_path(conn, :new))

      assert index_live
             |> form("#opportunity_erp_tag-form", opportunity_erp_tag: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#opportunity_erp_tag-form", opportunity_erp_tag: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.opportunity_erp_tag_index_path(conn, :index))

      assert html =~ "Opportunity erp tag created successfully"
    end

    test "updates opportunity_erp_tag in listing", %{conn: conn, opportunity_erp_tag: opportunity_erp_tag} do
      {:ok, index_live, _html} = live(conn, Routes.opportunity_erp_tag_index_path(conn, :index))

      assert index_live |> element("#opportunity_erp_tag-#{opportunity_erp_tag.id} a", "Edit") |> render_click() =~
               "Edit Opportunity erp tag"

      assert_patch(index_live, Routes.opportunity_erp_tag_index_path(conn, :edit, opportunity_erp_tag))

      assert index_live
             |> form("#opportunity_erp_tag-form", opportunity_erp_tag: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#opportunity_erp_tag-form", opportunity_erp_tag: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.opportunity_erp_tag_index_path(conn, :index))

      assert html =~ "Opportunity erp tag updated successfully"
    end

    test "deletes opportunity_erp_tag in listing", %{conn: conn, opportunity_erp_tag: opportunity_erp_tag} do
      {:ok, index_live, _html} = live(conn, Routes.opportunity_erp_tag_index_path(conn, :index))

      assert index_live |> element("#opportunity_erp_tag-#{opportunity_erp_tag.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#opportunity_erp_tag-#{opportunity_erp_tag.id}")
    end
  end

  describe "Show" do
    setup [:register_and_log_in_user, :create_opportunity_erp_tag]

    test "displays opportunity_erp_tag", %{conn: conn, opportunity_erp_tag: opportunity_erp_tag} do
      {:ok, _show_live, html} = live(conn, Routes.opportunity_erp_tag_show_path(conn, :show, opportunity_erp_tag))

      assert html =~ "Show Opportunity erp tag"
    end

    test "updates opportunity_erp_tag within modal", %{conn: conn, opportunity_erp_tag: opportunity_erp_tag} do
      {:ok, show_live, _html} = live(conn, Routes.opportunity_erp_tag_show_path(conn, :show, opportunity_erp_tag))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Opportunity erp tag"

      assert_patch(show_live, Routes.opportunity_erp_tag_show_path(conn, :edit, opportunity_erp_tag))

      assert show_live
             |> form("#opportunity_erp_tag-form", opportunity_erp_tag: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#opportunity_erp_tag-form", opportunity_erp_tag: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.opportunity_erp_tag_show_path(conn, :show, opportunity_erp_tag))

      assert html =~ "Opportunity erp tag updated successfully"
    end
  end
end
