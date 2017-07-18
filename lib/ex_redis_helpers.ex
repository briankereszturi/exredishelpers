defmodule ExRedisHelpers do
  alias Exredis, as: E
  alias Exredis.Api, as: R

  defp client(), do: Process.whereis(:redis_client)

  def get(key), do: client() |> R.get(key)
  def del(key), do: client() |> R.del(key)
  def set(key, value), do: client() |> R.set(key, value)

  def json_get(key, path \\ "."),
    do: client() |> E.query ["JSON.GET", key, path]

  def json_del(key, path \\ "."),
    do: client() |> E.query ["JSON.DEL", key, path]

  def json_set(key, path, value),
    do: client() |> E.query ["JSON.SET", key, path, value]
end
