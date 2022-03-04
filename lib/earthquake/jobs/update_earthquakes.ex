require Logger

defmodule Earthquake.UpdateEarthquakes do
  alias Earthquake.{EarthquakeRepository}

  @usgs_url "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/1.0_hour.geojson"

  def run do
    case HTTPoison.get(@usgs_url) do
      {:ok, %{status_code: 200, body: body}} ->
        response = Poison.decode!(body)
        insert_new_earthquakes(response)
      {:ok, %{status_code: 404}} ->
        Logger.info("404 not available")
      {:error, %{reason: reason}} ->
        Logger.error("Error encountered: #{reason}")
    end
  end

  defp insert_new_earthquakes(response) do
    features_map = Enum.group_by(response["features"], fn feature -> feature["id"] end)
    existing_usgs_ids = EarthquakeRepository.get_ids_for(Map.keys(features_map))
    new_features = List.flatten(Map.values(Map.drop(features_map, existing_usgs_ids)))
    EarthquakeRepository.batch_insert(new_features)
  end
end
