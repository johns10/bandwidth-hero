defmodule BandwidthHeroWeb.ContractorOpportunityLiveTest do
  use BandwidthHeroWeb.ConnCase

  import Phoenix.LiveViewTest
  import BandwidthHero.ContractorOpportunitiesFixtures

  @create_attrs %{message: "some message", subject: "some subject"}
  @update_attrs %{message: "some updated message", subject: "some updated subject"}
  @invalid_attrs %{message: nil, subject: nil}

  defp create_contractor_opportunity(_) do
    contractor_opportunity = contractor_opportunity_fixture()
    %{contractor_opportunity: contractor_opportunity}
  end

  describe "Index" do
    setup [:register_and_log_in_user, :create_contractor_opportunity]

    test "lists all contractor_opportunities", %{conn: conn, contractor_opportunity: contractor_opportunity} do
      {:ok, _index_live, html} = live(conn, Routes.contractor_opportunity_index_path(conn, :index))

      assert html =~ "Listing Contractor opportunities"
      assert html =~ contractor_opportunity.message
    end

    test "saves new contractor_opportunity", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.contractor_opportunity_index_path(conn, :index))

      assert index_live |> element("a", "New Contractor opportunity") |> render_click() =~
               "New Contractor opportunity"

      assert_patch(index_live, Routes.contractor_opportunity_index_path(conn, :new))

      assert index_live
             |> form("#contractor_opportunity-form", contractor_opportunity: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#contractor_opportunity-form", contractor_opportunity: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.contractor_opportunity_index_path(conn, :index))

      assert html =~ "Contractor opportunity created successfully"
      assert html =~ "some message"
    end

    test "updates contractor_opportunity in listing", %{conn: conn, contractor_opportunity: contractor_opportunity} do
      {:ok, index_live, _html} = live(conn, Routes.contractor_opportunity_index_path(conn, :index))

      assert index_live |> element("#contractor_opportunity-#{contractor_opportunity.id} a", "Edit") |> render_click() =~
               "Edit Contractor opportunity"

      assert_patch(index_live, Routes.contractor_opportunity_index_path(conn, :edit, contractor_opportunity))

      assert index_live
             |> form("#contractor_opportunity-form", contractor_opportunity: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#contractor_opportunity-form", contractor_opportunity: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.contractor_opportunity_index_path(conn, :index))

      assert html =~ "Contractor opportunity updated successfully"
      assert html =~ "some updated message"
    end

    test "deletes contractor_opportunity in listing", %{conn: conn, contractor_opportunity: contractor_opportunity} do
      {:ok, index_live, _html} = live(conn, Routes.contractor_opportunity_index_path(conn, :index))

      assert index_live |> element("#contractor_opportunity-#{contractor_opportunity.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#contractor_opportunity-#{contractor_opportunity.id}")
    end
  end

  describe "Show" do
    setup [:register_and_log_in_user, :create_contractor_opportunity]

    test "displays contractor_opportunity", %{conn: conn, contractor_opportunity: contractor_opportunity} do
      {:ok, _show_live, html} = live(conn, Routes.contractor_opportunity_show_path(conn, :show, contractor_opportunity))

      assert html =~ "Show Contractor opportunity"
      assert html =~ contractor_opportunity.message
    end

    test "updates contractor_opportunity within modal", %{conn: conn, contractor_opportunity: contractor_opportunity} do
      {:ok, show_live, _html} = live(conn, Routes.contractor_opportunity_show_path(conn, :show, contractor_opportunity))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Contractor opportunity"

      assert_patch(show_live, Routes.contractor_opportunity_show_path(conn, :edit, contractor_opportunity))

      assert show_live
             |> form("#contractor_opportunity-form", contractor_opportunity: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#contractor_opportunity-form", contractor_opportunity: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.contractor_opportunity_show_path(conn, :show, contractor_opportunity))

      assert html =~ "Contractor opportunity updated successfully"
      assert html =~ "some updated message"
    end
  end
end
