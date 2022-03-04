defmodule EarthquakeWeb.EarthquakeControllerTest do
  use EarthquakeWeb.ConnCase

  test "GET /api/earthquakes", %{conn: conn} do
    conn = get(conn, "/api/earthquakes")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
