defmodule BandwidthHeroWeb.OpportunityLiveTest do
  use BandwidthHeroWeb.ConnCase

  import Phoenix.LiveViewTest
  import BandwidthHero.OpportunitiesFixtures

  @create_attrs %{
    contract_type: [:corp_to_corp],
    description: "some description",
    from_date: %{day: 10, month: 11, year: 2022},
    hours_per_week: 42,
    laptop: [:use_my_own],
    name: "some name",
    rate: "120.5",
    to_date: %{day: 10, month: 11, year: 2022},
    travel: [:"100%"]
  }
  @update_attrs %{
    contract_type: [:contract_w2],
    description: "some updated description",
    from_date: %{day: 11, month: 11, year: 2022},
    hours_per_week: 43,
    laptop: [:use_provided_laptop],
    name: "some updated name",
    rate: "456.7",
    to_date: %{day: 11, month: 11, year: 2022},
    travel: [:"75%"]
  }
  @invalid_attrs %{
    contract_type: nil,
    description: nil,
    from_date: %{day: 30, month: 2, year: 2022},
    hours_per_week: nil,
    laptop: nil,
    name: nil,
    rate: nil,
    to_date: %{day: 30, month: 2, year: 2022},
    travel: nil
  }

  defp create_opportunity(_) do
    opportunity = opportunity_fixture()
    %{opportunity: opportunity}
  end

  describe "Index" do
    setup [:register_and_log_in_user, :create_opportunity]

    test "lists all opportunities", %{conn: conn, opportunity: opportunity} do
      {:ok, _index_live, html} = live(conn, Routes.opportunity_index_path(conn, :index))

      assert html =~ "Listing Opportunities"
      assert html =~ opportunity.description
    end

    test "saves new opportunity", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.opportunity_index_path(conn, :index))

      assert index_live |> element("a", "New Opportunity") |> render_click() =~
               "New Opportunity"

      assert_patch(index_live, Routes.opportunity_index_path(conn, :new))

      assert index_live
             |> form("#opportunity-form", opportunity: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#opportunity-form", opportunity: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.opportunity_index_path(conn, :index))

      assert html =~ "Opportunity created successfully"
      assert html =~ "some description"
    end

    test "updates opportunity in listing", %{conn: conn, opportunity: opportunity} do
      {:ok, index_live, _html} = live(conn, Routes.opportunity_index_path(conn, :index))

      assert index_live |> element("#opportunity-#{opportunity.id} a", "Edit") |> render_click() =~
               "Edit Opportunity"

      assert_patch(index_live, Routes.opportunity_index_path(conn, :edit, opportunity))

      assert index_live
             |> form("#opportunity-form", opportunity: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#opportunity-form", opportunity: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.opportunity_index_path(conn, :index))

      assert html =~ "Opportunity updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes opportunity in listing", %{conn: conn, opportunity: opportunity} do
      {:ok, index_live, _html} = live(conn, Routes.opportunity_index_path(conn, :index))

      assert index_live |> element("#opportunity-#{opportunity.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#opportunity-#{opportunity.id}")
    end
  end

  describe "Show" do
    setup [:register_and_log_in_user, :create_opportunity]

    test "displays opportunity", %{conn: conn, opportunity: opportunity} do
      {:ok, _show_live, html} = live(conn, Routes.opportunity_show_path(conn, :show, opportunity))

      assert html =~ "Show Opportunity"
      assert html =~ opportunity.description
    end

    test "updates opportunity within modal", %{conn: conn, opportunity: opportunity} do
      {:ok, show_live, _html} = live(conn, Routes.opportunity_show_path(conn, :show, opportunity))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Opportunity"

      assert_patch(show_live, Routes.opportunity_show_path(conn, :edit, opportunity))

      assert show_live
             |> form("#opportunity-form", opportunity: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#opportunity-form", opportunity: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.opportunity_show_path(conn, :show, opportunity))

      assert html =~ "Opportunity updated successfully"
      assert html =~ "some updated description"
    end
  end
end
