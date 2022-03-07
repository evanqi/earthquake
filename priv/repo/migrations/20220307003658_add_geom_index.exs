defmodule Earthquake.Repo.Migrations.AddGeomIndex do
  use Ecto.Migration

  def up do
    execute("CREATE INDEX earthquake_geom_index ON earthquake USING GIST(geom)")
  end

  def down do
    execute("DROP INDEX IF EXISTS earthquake_geom_index")
  end
end
