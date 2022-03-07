defmodule Earthquake.UpdateEarthquakesTest do
  use Earthquake.DataCase
  import Mox

  alias Earthquake.UpdateEarthquakes

  @http_client Earthquake.HTTPClientMock
  @test_config http_client: @http_client, url: "https://earthquake.usgs.gov"
  @success_resp %{
    "features" => [
      %{
        "type" => "Feature",
        "properties" => %{
          "mag" => 1.27,
          "place" => "20km E of Little Lake, CA",
          "time" => 1630456136690,
          "updated" => 1630456354801,
          "tz" => nil,
          "url" => "https://earthquake.usgs.gov/earthquakes/eventpage/ci40028704",
          "detail" => "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/ci40028704.geojson",
          "felt" => nil,
          "cdi" => nil,
          "mmi" => nil,
          "alert" => nil,
          "status" => "automatic",
          "tsunami" => 0,
          "sig" => 25,
          "net" => "ci",
          "code" => "40028704",
          "ids" => ",ci40028704,",
          "sources" => ",ci,",
          "types" => ",nearby-cities,origin,phase-data,scitech-link,",
          "nst" => 18,
          "dmin" => 0.03338,
          "rms" => 0.11,
          "gap" => 65,
          "magType" => "ml",
          "type" => "earthquake",
          "title" => "M 1.3 - 20km E of Little Lake, CA"
        },
        "geometry" => %{
          "type" => "Point",
          "coordinates" => [
          -117.682,
            35.9265,
            2.01
          ]
        },
        "id" => "ci40028704"
      }
    ]
  }

  describe "run" do
    test "returns new earthquake ids on successful response" do
      expect(@http_client, :get, fn "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/1.0_hour.geojson" ->
        {:ok, %HTTPoison.Response{body: @success_resp |> Poison.encode!(), status_code: 200}}
      end)

      assert {:ok, ["ci40028704"]} == UpdateEarthquakes.run(@test_config)
    end
  end
end
