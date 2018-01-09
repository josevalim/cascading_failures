defmodule CascadingFailures.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {CascadingFailures.SimpleSupervisor, :table},
      Supervisor.child_spec({CascadingFailures.DynamicSupervisor, {:table, 10_000}}, id: 1),
      Supervisor.child_spec({CascadingFailures.DynamicSupervisor, {:table, 10_000}}, id: 2),
      Supervisor.child_spec({CascadingFailures.DynamicSupervisor, {:table, 10_000}}, id: 3),
      Supervisor.child_spec({CascadingFailures.DynamicSupervisor, {:table, 10_000}}, id: 4)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [
      strategy: :one_for_one,
      name: CascadingFailures.Supervisor,
      max_restars: 200,
      max_seconds: 10
    ]

    Supervisor.start_link(children, opts)
  end
end
