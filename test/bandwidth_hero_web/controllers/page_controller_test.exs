defmodule BandwidthHeroWeb.PageControllerTest do
  use BandwidthHeroWeb.ConnCase

  test "GET /", %{conn: conn} do
    _conn = get(conn, "/")
    # assert html_response(conn, 200) =~ "Petal"
  end
end
