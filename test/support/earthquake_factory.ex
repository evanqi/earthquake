defmodule Earthquake.EarthquakeFactory do
  def build(:earthquake) do
    %Earthquake.EarthquakeModel{
      inserted_at: DateTime.truncate(DateTime.utc_now, :second),
      updated_at: DateTime.truncate(DateTime.utc_now, :second),
      usgs_id: "ak0222wk9e53",
      mag: 4.2,
      place: "0km E of San Francisco, CA",
      time: DateTime.from_unix!(1646437327, :second),
      usgs_updated_at: DateTime.from_unix!(1646437327, :second),
      usgs_url: "https://earthquake.usgs.gov/earthquakes/eventpage/ci40028704",
      usgs_detail_url: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/ci40028704.geojson",
      felt: nil,
      cdi: nil,
      mmi: nil,
      alert: nil,
      status: "automatic",
      tsunami: 0,
      sig: 25,
      net: "ci",
      code: "40028704",
      usgs_related_ids: ",ci40028704,",
      sources: ",ci,",
      types: ",nearby-cities,origin,phase-data,scitech-link,",
      nst: 18,
      dmin: 0.03338,
      rms: 0.11,
      gap: 65.2,
      mag_type: "ml",
      title: "M 1.3 - 20km E of Little Lake, CA",
      geom: %Geo.Point{ coordinates: { 37.7577627, -122.4726193 } }
    }
  end

  def build(:distant_earthquake) do
    %Earthquake.EarthquakeModel{
      inserted_at: DateTime.truncate(DateTime.utc_now, :second),
      updated_at: DateTime.truncate(DateTime.utc_now, :second),
      usgs_id: "ak0222wk9e53",
      mag: 4.2,
      place: "0km E of San Francisco, CA",
      time: DateTime.from_unix!(1646437327, :second),
      usgs_updated_at: DateTime.from_unix!(1646437327, :second),
      usgs_url: "https://earthquake.usgs.gov/earthquakes/eventpage/ci40028704",
      usgs_detail_url: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/ci40028704.geojson",
      felt: nil,
      cdi: nil,
      mmi: nil,
      alert: nil,
      status: "automatic",
      tsunami: 0,
      sig: 25,
      net: "ci",
      code: "40028704",
      usgs_related_ids: ",ci40028704,",
      sources: ",ci,",
      types: ",nearby-cities,origin,phase-data,scitech-link,",
      nst: 18,
      dmin: 0.03338,
      rms: 0.11,
      gap: 65.2,
      mag_type: "ml",
      title: "M 1.3 - 20km E of Little Lake, CA",
      geom: %Geo.Point{ coordinates: { -98.5552843, -56.7697996 } }
    }
  end
end
