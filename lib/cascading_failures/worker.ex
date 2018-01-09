defmodule CascadingFailures.Worker do
  use GenServer

  def start_link(table) do
    GenServer.start_link(__MODULE__, table)
  end

  def init(table) do
    {:ok, {table, 0}, 1}
  end

  def handle_info(:timeout, {table, counter}) do
    case :ets.lookup(table, counter) do
      [] -> {:noreply, {table, counter + 1}, 1}
      [_ | _] -> {:noreply, {table, counter - 1}, 1}
    end
  end
end
