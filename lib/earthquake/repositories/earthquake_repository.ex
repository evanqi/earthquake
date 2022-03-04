defmodule Earthquake.EarthquakeRepository do
  import Ecto.Query
  import Geo.PostGIS
  alias Earthquake.{EarthquakeModel, Repo}
  alias Ecto.Multi

  @miles_to_meters_conversion 1609.34

  def get_ids_for(usgs_ids) do
    query = from e in EarthquakeModel,
      where: e.usgs_id in ^usgs_ids,
      select: e.usgs_id
    Repo.all(query)
  end

  def batch_insert(features) do
    if length(features) != 0 do
      earthquake_models = Enum.map(
        features,
        fn feature ->
          now = DateTime.truncate(DateTime.utc_now, :second)
          %{
            inserted_at: now,
            updated_at: now,
            usgs_id: feature["id"],
            mag: feature["properties"]["mag"] / 1,
            place: feature["properties"]["place"],
            time: DateTime.truncate(
              DateTime.from_unix!(feature["properties"]["time"], :millisecond),
              :second
            ),
            usgs_updated_at: DateTime.truncate(
              DateTime.from_unix!(feature["properties"]["updated"], :millisecond),
              :second
            ),
            usgs_url: feature["properties"]["url"],
            usgs_detail_url: feature["properties"]["detail"],
            felt: feature["properties"]["felt"],
            cdi: feature["properties"]["cdi"],
            mmi: feature["properties"]["mmi"],
            alert: feature["properties"]["alert"],
            status: feature["properties"]["status"],
            tsunami: feature["properties"]["tsunami"],
            sig: feature["properties"]["sig"],
            net: feature["properties"]["net"],
            code: feature["properties"]["code"],
            usgs_related_ids: feature["properties"]["ids"],
            sources: feature["properties"]["sources"],
            types: feature["properties"]["types"],
            nst: feature["properties"]["nst"],
            dmin: feature["properties"]["dmin"],
            rms: feature["properties"]["rms"],
            gap: feature["properties"]["gap"],
            mag_type: feature["properties"]["magType"],
            title: feature["properties"]["title"],
            geom: %Geo.Point{
              coordinates: {
                Enum.at(feature["geometry"]["coordinates"], 0),
                Enum.at(feature["geometry"]["coordinates"], 1)
              }
            }
          }
        end
        )
      Multi.new()
      |> Multi.insert_all(:insert_all, EarthquakeModel, earthquake_models)
      |> Repo.transaction()
    end
  end

  def search(params) do
    query = EarthquakeModel
            |> where(^filter_where(params))
    Repo.all(query)
  end

  defp filter_where(params) do
    Enum.reduce(params, dynamic(true), fn
      {:starts_at, value}, dynamic ->
        dynamic([e], ^dynamic and e.time >= ^value)
      {:ends_at, value}, dynamic ->
        dynamic([e], ^dynamic and e.time <= ^value)
      {:min_mag, value}, dynamic ->
        dynamic([e], ^dynamic and e.mag >= ^value)
      {:max_mag, value}, dynamic ->
        dynamic([e], ^dynamic and e.mag <= ^value)
      {:radius, value}, dynamic ->
        case Map.fetch(params, :geom) do
          {:ok, nil} -> dynamic
          {:ok, geom} -> dynamic([e], ^dynamic and st_distancesphere(e.geom, ^geom) <= ^value * @miles_to_meters_conversion)
          :error -> dynamic
        end
      {_, _}, dynamic ->
        dynamic
    end)
  end
end
