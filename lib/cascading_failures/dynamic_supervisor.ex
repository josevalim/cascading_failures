defmodule CascadingFailures.DynamicSupervisor do
  use DynamicSupervisor

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg)
  end

  def init({table, counter}) do
    parent = self()

    spawn(fn ->
      for _ <- 1..counter do
        DynamicSupervisor.start_child(parent, {CascadingFailures.Worker, table})
      end
    end)

    DynamicSupervisor.init(max_restarts: counter * 10, max_seconds: 1, strategy: :one_for_one)
  end
end
