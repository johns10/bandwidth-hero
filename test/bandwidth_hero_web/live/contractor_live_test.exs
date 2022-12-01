defmodule BandwidthHeroWeb.ContractorLiveTest do
  use BandwidthHeroWeb.ConnCase

  import Phoenix.LiveViewTest
  import BandwidthHero.ContractorFixtures

  @create_attrs %{
    contract_type: [:corp_to_corp],
    international_travel: :yes,
    laptop: [:use_my_own],
    name: "some name",
    title: "some title",
    travel: [:"100%"]
  }
  @update_attrs %{
    contract_type: [:contract_w2],
    international_travel: :no,
    laptop: [:use_provided_laptop],
    name: "some updated name",
    title: "some updated title",
    travel: [:"75%"]
  }
  @invalid_attrs %{
    contract_type: nil,
    international_travel: nil,
    laptop: nil,
    name: nil,
    title: nil,
    travel: nil
  }

  defp create_contractor(%{user: user}) do
    contractor = contractor_fixture(%{user_id: user.id})
    %{contractor: contractor}
  end

  describe "Index" do
    setup [:register_and_log_in_user, :create_contractor]

    test "lists all contractors", %{conn: conn, contractor: contractor} do
      {:ok, _index_live, html} = live(conn, Routes.contractor_index_path(conn, :index))

      assert html =~ "Listing Contractors"
      assert html =~ contractor.name
    end

    test "updates contractor in listing", %{conn: conn, contractor: contractor} do
      {:ok, index_live, _html} = live(conn, Routes.contractor_index_path(conn, :index))

      assert index_live |> element("#contractor-#{contractor.id} a", "Edit") |> render_click() =~
               "Edit Contractor"

      assert_patch(index_live, Routes.contractor_index_path(conn, :edit, contractor))

      assert index_live
             |> form("#contractor-form", contractor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#contractor-form", contractor: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.contractor_index_path(conn, :index))

      assert html =~ "Contractor updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes contractor in listing", %{conn: conn, contractor: contractor} do
      {:ok, index_live, _html} = live(conn, Routes.contractor_index_path(conn, :index))

      assert index_live |> element("#contractor-#{contractor.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#contractor-#{contractor.id}")
    end
  end

  describe "Index without contractor" do
    setup [:register_and_log_in_user]

    test "saves new contractor", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.contractor_index_path(conn, :index))

      assert index_live |> element("a", "New Contractor") |> render_click() =~
               "New Contractor"

      assert_patch(index_live, Routes.contractor_index_path(conn, :new))

      assert index_live
             |> form("#contractor-form", contractor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#contractor-form", contractor: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.contractor_index_path(conn, :index))

      assert html =~ "Contractor created successfully"
      assert html =~ "some name"
    end
  end

  describe "Show" do
    setup [:register_and_log_in_user, :create_contractor]

    test "displays contractor", %{conn: conn, contractor: contractor} do
      {:ok, _show_live, html} = live(conn, Routes.contractor_show_path(conn, :show, contractor))

      assert html =~ "Show Contractor"
      assert html =~ contractor.name
    end

    test "updates contractor within modal", %{conn: conn, contractor: contractor} do
      {:ok, show_live, _html} = live(conn, Routes.contractor_show_path(conn, :show, contractor))

      assert show_live |> element("#edit-contractor") |> render_click() =~
               "Edit Contractor"

      assert_patch(show_live, Routes.contractor_show_path(conn, :edit, contractor))

      assert show_live
             |> form("#contractor-form", contractor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#contractor-form", contractor: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.contractor_show_path(conn, :show, contractor))

      assert html =~ "Contractor updated successfully"
      assert html =~ "some updated name"
    end
  end
end
