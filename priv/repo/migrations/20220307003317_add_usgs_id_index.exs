defmodule Earthquake.Repo.Migrations.AddUsgsIdIndex do
  use Ecto.Migration

  def up do
    create index("earthquake", [:usgs_id])
  end

  def down do
    drop index("earthquake", [:usgs_id])
  end
end
