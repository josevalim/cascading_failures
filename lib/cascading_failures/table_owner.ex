defmodule CascadingFailures.TableOwner do
  use GenServer

  def start_link(table) do
    GenServer.start_link(__MODULE__, table)
  end

  def init(table) do
    tid = :ets.new(table, [:named_table, :public, :set, read_concurrency: true])
    {:ok, tid, 10000}
  end

  def handle_info(:timeout, _state) do
    Process.exit(self(), :some_error)
  end
end
