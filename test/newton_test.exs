defmodule NewtonTest do
  use ExUnit.Case
  doctest Newton

  test "greets the world" do
    assert Newton.hello() == :world
  end
end
