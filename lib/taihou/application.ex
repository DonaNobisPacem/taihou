defmodule Taihou.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Taihou.Router, [],
        port: Application.get_env(:taihou, :port)
      )

      # Starts a worker by calling: Taihou.Worker.start_link(arg)
      # {Taihou.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Taihou.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
