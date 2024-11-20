defmodule CalculatorLogicTest do
  use ExUnit.Case

  alias CalculatorLogic

  describe "parse_input/1" do
    test "parses valid input correctly" do
      assert CalculatorLogic.parse_input("+5") == {:ok, "+", 5.0}
      assert CalculatorLogic.parse_input("-3.2") == {:ok, "-", 3.2}
      assert CalculatorLogic.parse_input("* 2") == {:ok, "*", 2.0}
      assert CalculatorLogic.parse_input("/4") == {:ok, "/", 4.0}
      assert CalculatorLogic.parse_input("% 3") == {:ok, "%", 3.0}
    end

    test "returns error for invalid input" do
      assert {:error, _} = CalculatorLogic.parse_input("invalid")
      assert {:error, _} = CalculatorLogic.parse_input("++5")
      assert {:error, _} = CalculatorLogic.parse_input("5+")
    end
  end

  describe "validate_operation/2" do
    test "allows valid operations" do
      assert CalculatorLogic.validate_operation("+", 5.0) == :ok
      assert CalculatorLogic.validate_operation("-", 3.0) == :ok
    end

    test "rejects division by zero" do
      assert CalculatorLogic.validate_operation("/", 0.0) ==
               {:error, "Cannot divide by zero."}
    end

    test "rejects modulo by zero" do
      assert CalculatorLogic.validate_operation("%", 0.0) ==
               {:error, "Cannot modulo by zero."}
    end

    test "rejects invalid operators" do
      assert {:error, _} = CalculatorLogic.validate_operation("^", 2.0)
    end
  end

  describe "calculate/3" do
    test "performs addition" do
      assert CalculatorLogic.calculate(5.0, "+", 3.0) == {:ok, 8.0}
    end

    test "performs subtraction" do
      assert CalculatorLogic.calculate(5.0, "-", 3.0) == {:ok, 2.0}
    end

    test "performs multiplication" do
      assert CalculatorLogic.calculate(5.0, "*", 3.0) == {:ok, 15.0}
    end

    test "performs division" do
      assert CalculatorLogic.calculate(9.0, "/", 3.0) == {:ok, 3.0}
    end

    test "performs modulo" do
      assert CalculatorLogic.calculate(10.0, "%", 3.0) == {:ok, 1}
    end
  end
end
