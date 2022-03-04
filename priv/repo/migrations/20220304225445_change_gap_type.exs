defmodule Earthquake.Repo.Migrations.ChangeGapType do
  use Ecto.Migration

  def change do
    alter table(:earthquake) do
      modify :gap, :float
    end
  end
end
