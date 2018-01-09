defmodule CascadingFailures.SimpleSupervisor do
  use Supervisor

  def start_link(table) do
    Supervisor.start_link(__MODULE__, table)
  end

  def init(table) do
    Supervisor.init(
      [{CascadingFailures.TableOwner, table}],
      max_restarts: 10,
      max_seconds: 2,
      strategy: :one_for_one
    )
  end
end
