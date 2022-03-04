require Logger

defmodule EarthquakeWeb.EarthquakeController do
  use EarthquakeWeb, :controller
  alias Earthquake.{EarthquakeRepository}

  def index(conn, params) do
    search_params = %{
      starts_at: starts_at_param(params),
      ends_at: ends_at_param(params),
      min_mag: min_mag_param(params),
      max_mag: max_mag_param(params),
      geom: build_geom(lat_param(params), lng_param(params)),
      radius: radius_param(params)
    }
    |> Enum.filter(fn {_, v} -> v end)
    |> Enum.into(%{})
    results = EarthquakeRepository.search(search_params)

    json(conn, results)
  end

  defp starts_at_param(params) do
    case extract_param(params, "starts_at") do
      nil -> nil
      value ->
        {starts_at, _} = Integer.parse(value)
        DateTime.from_unix!(starts_at, :second)
    end
  end

  defp ends_at_param(params) do
    case extract_param(params, "ends_at") do
      nil -> nil
      value ->
        {ends_at, _} = Integer.parse(value)
        DateTime.from_unix!(ends_at, :second)
    end
  end

  defp min_mag_param(params) do
    case extract_param(params, "min_mag") do
      nil -> nil
      value ->
        {min_mag, _} = Float.parse(value)
        min_mag
    end
  end

  defp max_mag_param(params) do
    case extract_param(params, "max_mag") do
      nil -> nil
      value ->
        {max_mag, _} = Float.parse(value)
        max_mag
    end
  end

  defp build_geom(_, nil) do
    nil
  end

  defp build_geom(nil, _) do
    nil
  end

  defp build_geom(lat, lng) do
    %Geo.Point{ coordinates: { lat, lng } }
  end

  defp lat_param(params) do
    case extract_param(params, "lat") do
      nil -> nil
      value ->
        {lat, _} = Float.parse(value)
        lat
    end
  end

  defp lng_param(params) do
    case extract_param(params, "lng") do
      nil -> nil
      value ->
        {lng, _} = Float.parse(value)
        lng
    end
  end

  defp radius_param(params) do
    case extract_param(params, "radius") do
      nil -> nil
      value ->
        {radius, _} = Float.parse(value)
        radius
    end
  end

  defp extract_param(params, key) do
    case Map.fetch(params, key) do
      {:ok, nil} -> nil
      {:ok, value} -> value
      :error -> nil
    end
  end
end
