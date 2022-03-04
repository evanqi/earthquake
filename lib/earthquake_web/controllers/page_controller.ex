defmodule EarthquakeWeb.PageController do
  use EarthquakeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
