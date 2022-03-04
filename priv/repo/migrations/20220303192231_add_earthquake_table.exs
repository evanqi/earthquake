defmodule Earthquake.Repo.Migrations.AddEarthquakeTable do
  use Ecto.Migration

  def up do
    create table("earthquake") do
      add :usgs_id, :string
      add :mag, :float
      add :place, :string
      add :time, :utc_datetime
      add :usgs_updated_at, :utc_datetime
      add :usgs_url, :string
      add :usgs_detail_url, :string
      add :felt, :integer
      add :cdi, :float
      add :mmi, :float
      add :alert, :string
      add :status, :string
      add :tsunami, :integer
      add :sig, :integer
      add :net, :string
      add :code, :string
      add :usgs_related_ids, :string
      add :sources, :string
      add :types, :string
      add :nst, :integer
      add :dmin, :float
      add :rms, :float
      add :gap, :integer
      add :mag_type, :string
      add :title, :string
      add :geom, :geometry

      timestamps()
    end
  end

  def down do
    drop table("earthquake")
  end
end
