defmodule ExredisHelpers do
  import Exredis.Api

  defp client(), do: Process.whereis(:redis_client)

  def get(key), do: client() |> get(key)
  def del(key), do: client() |> del(key)
  def set(key, value), do: client() |> set(key, value)
end
