for _ <- 1..20 do
  spawn(fn ->
    Process.flag(:trap_exit, true)

    [1, 2, 3]
    |> Stream.cycle()
    |> Task.async_stream(
      fn i ->
        for _ <- 1..i do
          require Logger
          Logger.error(List.duplicate(String.duplicate("oops ", 4), 10))
        end
      end,
      max_concurrency: 1000,
      ordered: false,
      timeout: 5000
    )
    |> Stream.run()
  end)
end
