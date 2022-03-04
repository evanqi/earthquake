defmodule Earthquake.Repo do
  use Ecto.Repo,
    otp_app: :earthquake,
    adapter: Ecto.Adapters.Postgres
end
