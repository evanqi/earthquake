import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :earthquake, Earthquake.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "earthquake_test#{System.get_env("MIX_TEST_PARTITION")}",
  types: Earthquake.PostgresTypes,
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :earthquake, EarthquakeWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "4myqHet2vkGtrrAdLZEi7P0rySlxsZcKA4of6EQATa+nirTpijcOKTFDme3kkMAN",
  server: false

config :earthquake, :update_earthquakes,
  http_client: Earthquake.HTTPClientMock,
  url: "https://earthquake.usgs.gov"

# In test we don't send emails.
config :earthquake, Earthquake.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
