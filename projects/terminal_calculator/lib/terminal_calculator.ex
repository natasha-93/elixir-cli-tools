defmodule TerminalCalculator do
  @moduledoc """
  A simple terminal-based calculator supporting addition (+), subtraction (-),
  multiplication (*), division (/), and modulo (%).
  """

  @valid_operators ["+", "-", "*", "/", "%"]
  @operator_regex ~r|^\s*(?<operator>[+\-*/%])\s*(?<operand>-?\d+(?:\.\d+)?)\s*$|

  def main do
    IO.puts("Welcome to the Terminal Calculator!")
    run_calculator(0)
  end

  defp run_calculator(current_result) do
    IO.puts("\nCurrent result: #{current_result}")

    IO.puts(
      "Enter an operation (e.g., +5, -3, *2, /4, %3), 'help' for instructions, or 'exit' to quit:"
    )

    IO.gets("> ")
    |> String.trim()
    |> handle_input(current_result)
    |> case do
      :exit -> IO.puts("Goodbye!")
      new_result -> run_calculator(new_result)
    end
  end

  defp handle_input("exit", _current_result), do: :exit

  defp handle_input("help", current_result) do
    IO.puts("Supported operations: #{Enum.join(@valid_operators, ", ")}.")
    IO.puts("Usage: <operator><number> (e.g., +5, -3, *2, /4, %3).")
    current_result
  end

  defp handle_input(input, current_result) do
    case parse_input(input) do
      {:ok, operator, operand} ->
        case validate_operation(operator, operand) do
          :ok ->
            case calculate(current_result, operator, operand) do
              {:ok, new_result} ->
                new_result

              {:error, message} ->
                IO.puts(message)
                current_result
            end

          {:error, message} ->
            IO.puts(message)
            current_result
        end

      {:error, message} ->
        IO.puts(message)
        current_result
    end
  end

  defp parse_input(input) do
    case Regex.named_captures(@operator_regex, input) do
      %{"operator" => operator, "operand" => operand_str} ->
        case Float.parse(operand_str) do
          {operand, ""} ->
            {:ok, operator, operand}

          _ ->
            {:error, "Invalid number format. Ensure the operand is a valid number."}
        end

      nil ->
        {:error,
         "Invalid input. Use format: <operator><number> (e.g., +5, -3). Supported operators: #{Enum.join(@valid_operators, ", ")}."}
    end
  end

  defp validate_operation("/", 0.0), do: {:error, "Cannot divide by zero."}
  defp validate_operation("%", 0.0), do: {:error, "Cannot modulo by zero."}
  defp validate_operation(op, _) when op in @valid_operators, do: :ok

  defp validate_operation(op, _),
    do:
      {:error,
       "Invalid operator '#{op}'. Supported operators: #{Enum.join(@valid_operators, ", ")}."}

  defp calculate(result, "+", operand), do: {:ok, result + operand}
  defp calculate(result, "-", operand), do: {:ok, result - operand}
  defp calculate(result, "*", operand), do: {:ok, result * operand}
  defp calculate(result, "/", operand), do: {:ok, result / operand}
  defp calculate(result, "%", operand), do: {:ok, rem(trunc(result), trunc(operand))}
end
