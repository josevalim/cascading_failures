defmodule CascadingFailuresTest do
  use ExUnit.Case
  doctest CascadingFailures

  test "greets the world" do
    assert CascadingFailures.hello() == :world
  end
end
