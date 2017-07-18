defmodule ExRedisHelpers do
  alias Exredis, as: E
  alias Exredis.Api, as: R

  defp client(), do: Process.whereis(:redis_client)

  def get(key), do: client() |> R.get(key)
  def del(key), do: client() |> R.del(key)
  def set(key, value), do: client() |> R.set(key, value)

  defp handle_json_result(result) do
    case result do
      "OK" -> :ok
      "ERR new objects must be created at the root" -> {:error, :not_found}
      r -> r
    end
  end

  def json_get(key, path \\ "."),
    do: client() |> E.query(["JSON.GET", key, path]) |> handle_json_result()

  def json_del(key, path \\ "."),
    do: client() |> E.query(["JSON.DEL", key, path]) |> handle_json_result()

  def json_set(key, path, value),
    do: client() |> E.query(["JSON.SET", key, path, value]) |> handle_json_result()
end
