defmodule BandwidthHeroWeb.ContractorErpTagLiveTest do
  use BandwidthHeroWeb.ConnCase

  import Phoenix.LiveViewTest
  import BandwidthHero.ContractorErpTagsFixtures
  import BandwidthHero.ContractorFixtures
  import BandwidthHero.TagsFixtures

  def create_attrs(%{erp_tag: e}), do: %{"projects" => 42, "years" => 42, "erp_tag_id" => e.id}
  def update_attrs(%{erp_tag: e}), do: %{"projects" => 43, "years" => 43, "erp_tag_id" => e.id}
  @invalid_attrs %{contractor_id: nil, erp_tag_id: nil}

  defp create_contractor(_) do
    contractor = contractor_fixture()
    %{contractor: contractor}
  end

  defp create_erp_tag(_) do
    erp_tag = erp_tag_fixture()
    %{erp_tag: erp_tag}
  end

  defp create_contractor_erp_tag(%{contractor: c, erp_tag: e}) do
    contractor_erp_tag = contractor_erp_tag_fixture(%{contractor_id: c.id, erp_tag_id: e.id})
    %{contractor_erp_tag: contractor_erp_tag}
  end

  describe "Index" do
    setup [
      :register_and_log_in_user,
      :create_contractor,
      :create_erp_tag,
      :create_contractor_erp_tag
    ]

    test "lists all contractor_erp_tag", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.contractor_erp_tag_index_path(conn, :index))

      assert html =~ "Listing Contractor erp tag"
    end

    test "updates contractor_erp_tag in listing",
         %{conn: conn, contractor_erp_tag: contractor_erp_tag} = context do
      {:ok, index_live, _html} = live(conn, Routes.contractor_erp_tag_index_path(conn, :index))

      assert index_live
             |> element("#contractor_erp_tag-#{contractor_erp_tag.id} a", "Edit")
             |> render_click() =~
               "Edit Contractor erp tag"

      assert_patch(
        index_live,
        Routes.contractor_erp_tag_index_path(conn, :edit, contractor_erp_tag)
      )

      assert index_live
             |> form("#contractor_erp_tag-form", contractor_erp_tag: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#contractor_erp_tag-form", contractor_erp_tag: update_attrs(context))
        |> render_submit(%{contractor_erp_tag: %{"contractor_id" => context.contractor.id}})
        |> follow_redirect(conn, Routes.contractor_erp_tag_index_path(conn, :index))

      assert html =~ "Contractor erp tag updated successfully"
    end
  end

  describe "Index with no contractor erp tag" do
    setup [
      :register_and_log_in_user,
      :create_contractor,
      :create_erp_tag
    ]

    test "saves new contractor_erp_tag", %{conn: conn} = context do
      {:ok, index_live, _html} = live(conn, Routes.contractor_erp_tag_index_path(conn, :index))

      assert index_live |> element("a", "New Contractor Erp Tag") |> render_click() =~
               "New Contractor Erp Tag"

      assert_patch(index_live, Routes.contractor_erp_tag_index_path(conn, :new))

      assert index_live
             |> form("#contractor_erp_tag-form", contractor_erp_tag: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#contractor_erp_tag-form", contractor_erp_tag: create_attrs(context))
        |> render_submit(%{contractor_erp_tag: %{"contractor_id" => context.contractor.id}})
        |> follow_redirect(conn, Routes.contractor_erp_tag_index_path(conn, :index))

      assert html =~ "Contractor erp tag created successfully"
    end
  end

  describe "Show" do
    setup [
      :register_and_log_in_user,
      :create_contractor,
      :create_erp_tag,
      :create_contractor_erp_tag
    ]

    test "displays contractor_erp_tag", %{conn: conn, contractor_erp_tag: contractor_erp_tag} do
      {:ok, _show_live, html} =
        live(conn, Routes.contractor_erp_tag_show_path(conn, :show, contractor_erp_tag))

      assert html =~ "Show Contractor erp tag"
    end

    test "updates contractor_erp_tag within modal",
         %{conn: conn, contractor_erp_tag: contractor_erp_tag} = context do
      {:ok, show_live, _html} =
        live(conn, Routes.contractor_erp_tag_show_path(conn, :show, contractor_erp_tag))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Contractor erp tag"

      assert_patch(
        show_live,
        Routes.contractor_erp_tag_show_path(conn, :edit, contractor_erp_tag)
      )

      assert show_live
             |> form("#contractor_erp_tag-form", contractor_erp_tag: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#contractor_erp_tag-form", contractor_erp_tag: update_attrs(context))
        |> render_submit(%{contractor_erp_tag: %{"contractor_id" => context.contractor.id}})
        |> follow_redirect(
          conn,
          Routes.contractor_erp_tag_show_path(conn, :show, contractor_erp_tag)
        )

      assert html =~ "Contractor erp tag updated successfully"
    end
  end
end
