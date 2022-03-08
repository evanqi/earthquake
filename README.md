# Earthquake

## Prerequisites

Follow the [installation guide](https://hexdocs.pm/phoenix/installation.html) to make sure you can run a Phoenix application.

## Running the application

To start the server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Earthquakes API

Visit `localhost:4000/api/earthquakes` for the API that searches for earthquakes by the following filters passed in as query parameters:
* starts_at (int): this will be in epoch time
* ends_at (int): this will be in epoch time
* min_mag (float): minimum magnitude
* max_mag (float): maximum magnitude
* radius (int): searches for earthquakes within an N mile radius of (lat, lng)
* lat (float): latitude
* lng (float): longitude

### Updating the earthquakes database

`Earthquake.UpdateEarthquakes` is a job that runs every minute, checking the USGS API for earthquakes in the last hour and inserting new ones into the database.

## Tests

Run the test suite with `mix test`
