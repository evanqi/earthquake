ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Earthquake.Repo, :manual)
Mox.defmock(Earthquake.HTTPClientMock, for: HTTPoison.Base)
