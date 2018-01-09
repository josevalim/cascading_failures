for _ <- 1..20 do
  spawn(fn ->
    for i <- Stream.cycle([1, 2, 3]) do
      Process.sleep(1)

      spawn(fn ->
        for _ <- 1..i do
          require Logger
          Logger.error(List.duplicate(String.duplicate("oops ", 4), 10))
        end
      end)
    end
  end)
end
