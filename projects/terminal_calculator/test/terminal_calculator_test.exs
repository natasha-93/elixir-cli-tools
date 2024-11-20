defmodule TerminalCalculatorTest do
  use ExUnit.Case
  doctest TerminalCalculator

  test "greets the world" do
    assert TerminalCalculator.hello() == :world
  end
end
