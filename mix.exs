defmodule ExRedisHelpers.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_redis_helpers,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger],
     mod: {ExRedisHelpers.Application, []}]
  end

  defp deps do
    [
      {:exredis, ">= 0.2.4"},
      {:retry, "~> 0.6.0"}
    ]
  end
end
