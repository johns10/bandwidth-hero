defmodule BandwidthHeroWeb.CertificateLiveTest do
  use BandwidthHeroWeb.ConnCase

  import Phoenix.LiveViewTest
  import BandwidthHero.CertificatesFixtures

  @create_attrs %{description: "some description", label: "some label"}
  @update_attrs %{description: "some updated description", label: "some updated label"}
  @invalid_attrs %{description: nil, label: nil}

  defp create_certificate(_) do
    certificate = certificate_fixture()
    %{certificate: certificate}
  end

  describe "Index" do
    setup [:create_certificate]

    test "lists all certificate", %{conn: conn, certificate: certificate} do
      {:ok, _index_live, html} = live(conn, Routes.certificate_index_path(conn, :index))

      assert html =~ "Listing Certificate"
      assert html =~ certificate.description
    end

    test "saves new certificate", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.certificate_index_path(conn, :index))

      assert index_live |> element("a", "New Certificate") |> render_click() =~
               "New Certificate"

      assert_patch(index_live, Routes.certificate_index_path(conn, :new))

      assert index_live
             |> form("#certificate-form", certificate: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#certificate-form", certificate: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.certificate_index_path(conn, :index))

      assert html =~ "Certificate created successfully"
      assert html =~ "some description"
    end

    test "updates certificate in listing", %{conn: conn, certificate: certificate} do
      {:ok, index_live, _html} = live(conn, Routes.certificate_index_path(conn, :index))

      assert index_live |> element("#certificate-#{certificate.id} a", "Edit") |> render_click() =~
               "Edit Certificate"

      assert_patch(index_live, Routes.certificate_index_path(conn, :edit, certificate))

      assert index_live
             |> form("#certificate-form", certificate: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#certificate-form", certificate: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.certificate_index_path(conn, :index))

      assert html =~ "Certificate updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes certificate in listing", %{conn: conn, certificate: certificate} do
      {:ok, index_live, _html} = live(conn, Routes.certificate_index_path(conn, :index))

      assert index_live |> element("#certificate-#{certificate.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#certificate-#{certificate.id}")
    end
  end

  describe "Show" do
    setup [:create_certificate]

    test "displays certificate", %{conn: conn, certificate: certificate} do
      {:ok, _show_live, html} = live(conn, Routes.certificate_show_path(conn, :show, certificate))

      assert html =~ "Show Certificate"
      assert html =~ certificate.description
    end

    test "updates certificate within modal", %{conn: conn, certificate: certificate} do
      {:ok, show_live, _html} = live(conn, Routes.certificate_show_path(conn, :show, certificate))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Certificate"

      assert_patch(show_live, Routes.certificate_show_path(conn, :edit, certificate))

      assert show_live
             |> form("#certificate-form", certificate: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#certificate-form", certificate: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.certificate_show_path(conn, :show, certificate))

      assert html =~ "Certificate updated successfully"
      assert html =~ "some updated description"
    end
  end
end
