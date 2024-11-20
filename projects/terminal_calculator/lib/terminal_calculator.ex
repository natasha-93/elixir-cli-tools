defmodule TerminalCalculator do
  @moduledoc """
  A simple terminal-based calculator supporting basic arithmetic operations.
  """

  @spec main() :: :ok
  def main do
    IO.puts("Welcome to the Terminal Calculator!")
    run_calculator(0.0)
  end

  defp run_calculator(current_result) do
    IO.puts("\nCurrent result: #{current_result}")

    IO.puts(
      "Enter an operation (e.g., +5, -3, *2, /4, %3), 'help' for instructions, or 'exit' to quit:"
    )

    input =
      case IO.gets("> ") do
        :eof ->
          "exit"

        {:error, _reason} ->
          "exit"

        line ->
          String.trim(line)
      end

    case handle_input(input, current_result) do
      :exit ->
        IO.puts("Goodbye!")

      new_result ->
        run_calculator(new_result)
    end
  end

  defp handle_input("exit", _current_result), do: :exit

  defp handle_input("help", current_result) do
    IO.puts("Supported operations: +, -, *, /, %.")
    IO.puts("Usage: <operator><number> (e.g., +5, -3, *2, /4, %3).")
    current_result
  end

  defp handle_input(input, current_result) do
    case CalculatorLogic.parse_input(input) do
      {:ok, operator, operand} ->
        case CalculatorLogic.validate_operation(operator, operand) do
          :ok ->
            {:ok, new_result} = CalculatorLogic.calculate(current_result, operator, operand)
            run_calculator(new_result)

          {:error, message} ->
            IO.puts(message)
            run_calculator(current_result)
        end

      {:error, message} ->
        IO.puts(message)
        run_calculator(current_result)
    end
  end
end
