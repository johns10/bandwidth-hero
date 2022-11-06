defmodule BandwidthHeroWeb.AvailabilityLiveTest do
  use BandwidthHeroWeb.ConnCase

  import Phoenix.LiveViewTest
  import BandwidthHero.AvailabilitiesFixtures

  @create_attrs %{
    available_from: %{day: 4, month: 11, year: 2022},
    available_to: %{day: 4, month: 11, year: 2023},
    hours: 10
  }
  @update_attrs %{
    available_from: %{day: 5, month: 11, year: 2022},
    available_to: %{day: 5, month: 11, year: 2023},
    hours: 20
  }
  @invalid_attrs %{
    available_from: %{day: 30, month: 2, year: 2022},
    available_to: %{day: 30, month: 2, year: 2022},
    hours: nil
  }

  defp create_availability(_) do
    availability = availability_fixture()
    %{availability: availability}
  end

  describe "Index" do
    setup [:create_availability]

    test "lists all availabilities", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.availability_index_path(conn, :index))

      assert html =~ "Listing Availabilities"
    end

    test "saves new availability", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.availability_index_path(conn, :index))

      assert index_live |> element("a", "New Availability") |> render_click() =~
               "New Availability"

      assert_patch(index_live, Routes.availability_index_path(conn, :new))

      assert index_live
             |> form("#availability-form", availability: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#availability-form", availability: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.availability_index_path(conn, :index))

      assert html =~ "Availability created successfully"
    end

    test "updates availability in listing", %{conn: conn, availability: availability} do
      {:ok, index_live, _html} = live(conn, Routes.availability_index_path(conn, :index))

      assert index_live |> element("#availability-#{availability.id} a", "Edit") |> render_click() =~
               "Edit Availability"

      assert_patch(index_live, Routes.availability_index_path(conn, :edit, availability))

      assert index_live
             |> form("#availability-form", availability: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#availability-form", availability: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.availability_index_path(conn, :index))

      assert html =~ "Availability updated successfully"
    end

    test "deletes availability in listing", %{conn: conn, availability: availability} do
      {:ok, index_live, _html} = live(conn, Routes.availability_index_path(conn, :index))

      assert index_live
             |> element("#availability-#{availability.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#availability-#{availability.id}")
    end
  end

  describe "Show" do
    setup [:create_availability]

    test "displays availability", %{conn: conn, availability: availability} do
      {:ok, _show_live, html} =
        live(conn, Routes.availability_show_path(conn, :show, availability))

      assert html =~ "Show Availability"
    end

    test "updates availability within modal", %{conn: conn, availability: availability} do
      {:ok, show_live, _html} =
        live(conn, Routes.availability_show_path(conn, :show, availability))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Availability"

      assert_patch(show_live, Routes.availability_show_path(conn, :edit, availability))

      assert show_live
             |> form("#availability-form", availability: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#availability-form", availability: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.availability_show_path(conn, :show, availability))

      assert html =~ "Availability updated successfully"
    end
  end
end
