defmodule ExredisHelpers.Application do
  @moduledoc false

  use Application
  use Retry

  import Stream

  require Logger

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(__MODULE__, [], function: :wait_for_redis)
    ]

    opts = [strategy: :one_for_one, name: Redis.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def wait_for_redis() do
    {:ok, client} = retry with: cycle([5_000]) do
      Logger.info "Attempting to connect to Redis..."
      Exredis.start_link()
    end
    Logger.info "Connected to Redis."

    Process.register(client, :redis_client)
    {:ok, client}
  end
end
