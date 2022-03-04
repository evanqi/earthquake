defmodule EarthquakeWeb.EarthquakeControllerTest do
  use EarthquakeWeb.ConnCase
  alias Earthquake.{EarthquakeFactory, Repo}

  describe "index" do
    test "GET /api/earthquakes", %{conn: conn} do
      earthquake = EarthquakeFactory.build(:earthquake) |> Repo.insert!
      conn = get(conn, "/api/earthquakes")
      assert json_response(conn, 200)["data"] == [
        %{
          "usgs_id" => earthquake.usgs_id,
          "mag" => earthquake.mag,
          "place" => earthquake.place,
          "time" => DateTime.to_iso8601(earthquake.time),
          "usgs_url" => earthquake.usgs_url,
          "usgs_detail_url" => earthquake.usgs_detail_url,
          "geom" => %{
            "coordinates" => [
              elem(earthquake.geom.coordinates, 0),
              elem(earthquake.geom.coordinates, 1)
            ],
            "type" => "Point"
          }
        }
      ]
    end
  end
end
