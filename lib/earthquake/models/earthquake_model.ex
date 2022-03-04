defmodule Earthquake.EarthquakeModel do
  use Ecto.Schema

  @derive{Jason.Encoder, only: [:usgs_id, :mag, :place, :time, :usgs_url, :usgs_detail_url, :geom]}
  schema "earthquake" do
      field :usgs_id, :string
      field :mag, :float
      field :place, :string
      field :time, :utc_datetime
      field :usgs_updated_at, :utc_datetime
      field :usgs_url, :string
      field :usgs_detail_url, :string
      field :felt, :integer
      field :cdi, :float
      field :mmi, :float
      field :alert, :string
      field :status, :string
      field :tsunami, :integer
      field :sig, :integer
      field :net, :string
      field :code, :string
      field :usgs_related_ids, :string
      field :sources, :string
      field :types, :string
      field :nst, :integer
      field :dmin, :float
      field :rms, :float
      field :gap, :integer
      field :mag_type, :string
      field :title, :string
      field :geom, Geo.PostGIS.Geometry
      field :inserted_at, :utc_datetime
      field :updated_at, :utc_datetime
  end
end
