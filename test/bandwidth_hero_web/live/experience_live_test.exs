defmodule BandwidthHeroWeb.ExperienceLiveTest do
  use BandwidthHeroWeb.ConnCase

  import Phoenix.LiveViewTest
  import BandwidthHero.ExperiencesFixtures

  @create_attrs %{
    description: "some description",
    from: %{day: 29, month: 10, year: 2022},
    label: "some label",
    to: %{day: 29, month: 10, year: 2022}
  }
  @update_attrs %{
    description: "some updated description",
    from: %{day: 30, month: 10, year: 2022},
    label: "some updated label",
    to: %{day: 30, month: 10, year: 2022}
  }
  @invalid_attrs %{
    description: nil,
    from: %{day: 30, month: 2, year: 2022},
    label: nil,
    to: %{day: 30, month: 2, year: 2022}
  }

  defp create_experience(_) do
    experience = experience_fixture()
    %{experience: experience}
  end

  describe "Index" do
    setup [:register_and_log_in_user, :create_experience]

    test "lists all experience", %{conn: conn, experience: experience} do
      {:ok, _index_live, html} = live(conn, Routes.experience_index_path(conn, :index))

      assert html =~ "Listing Experience"
      assert html =~ experience.description
    end

    test "saves new experience", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.experience_index_path(conn, :index))

      assert index_live |> element("a", "New experience") |> render_click() =~
               "New experience"

      assert_patch(index_live, Routes.experience_index_path(conn, :new))

      assert index_live
             |> form("#experience-form", experience: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#experience-form", experience: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.experience_index_path(conn, :index))

      assert html =~ "Experience created successfully"
      assert html =~ "some description"
    end

    test "updates experience in listing", %{conn: conn, experience: experience} do
      {:ok, index_live, _html} = live(conn, Routes.experience_index_path(conn, :index))

      assert index_live |> element("#experience-#{experience.id} a", "Edit") |> render_click() =~
               "Edit Experience"

      assert_patch(index_live, Routes.experience_index_path(conn, :edit, experience))

      assert index_live
             |> form("#experience-form", experience: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#experience-form", experience: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.experience_index_path(conn, :index))

      assert html =~ "Experience updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes experience in listing", %{conn: conn, experience: experience} do
      {:ok, index_live, _html} = live(conn, Routes.experience_index_path(conn, :index))

      assert index_live |> element("#experience-#{experience.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#experience-#{experience.id}")
    end
  end

  describe "Show" do
    setup [:register_and_log_in_user, :create_experience]

    test "displays experience", %{conn: conn, experience: experience} do
      {:ok, _show_live, html} = live(conn, Routes.experience_show_path(conn, :show, experience))

      assert html =~ "Show Experience"
      assert html =~ experience.description
    end

    test "updates experience within modal", %{conn: conn, experience: experience} do
      {:ok, show_live, _html} = live(conn, Routes.experience_show_path(conn, :show, experience))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Experience"

      assert_patch(show_live, Routes.experience_show_path(conn, :edit, experience))

      assert show_live
             |> form("#experience-form", experience: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#experience-form", experience: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.experience_show_path(conn, :show, experience))

      assert html =~ "Experience updated successfully"
      assert html =~ "some updated description"
    end
  end
end
