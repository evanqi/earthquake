require Logger

defmodule Earthquake.UpdateEarthquakes do
  alias Earthquake.{EarthquakeRepository}

  @earthquake_path "/earthquakes/feed/v1.0/summary/1.0_hour.geojson"

  def run(config \\ default_config()) do
    url = Keyword.get(config, :url, "") <> @earthquake_path
    http_client = Keyword.get(config, :http_client)

    url
    |> http_client.get()
    |> handle()
  end

  defp handle({:ok, %HTTPoison.Response{body: body, status_code: 200}}),
    do: insert_new_earthquakes(Poison.decode!(body))

  defp handle({:ok, %HTTPoison.Response{body: body, status_code: code}}),
    do: Logger.info("[USGS] Response received with status code #{code}, body: #{body}")

  defp handle({:error, %{reason: reason}}), do: Logger.error("[USGS] Error encountered: #{reason}")

  # Filters list of earthquake ids for ones that don't currently exist in DB
  # and batch inserts new ones into DB. Performance could be improved by caching
  # response of most recent USGS ids and comparing subsequent responses.
  defp insert_new_earthquakes(response) do
    features_map = Enum.group_by(response["features"], fn feature -> feature["id"] end)
    existing_usgs_ids = EarthquakeRepository.get_ids_for(Map.keys(features_map))
    new_features = List.flatten(Map.values(Map.drop(features_map, existing_usgs_ids)))
    EarthquakeRepository.batch_insert(new_features)

    {:ok, Enum.map(new_features, fn feature -> feature["id"] end)}
  end

  def default_config(), do: Application.get_env(:earthquake, :update_earthquakes)
end
