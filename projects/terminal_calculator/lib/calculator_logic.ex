defmodule CalculatorLogic do
  @moduledoc """
  Contains the logic for parsing user input, validating operations, and performing calculations
  for the Terminal Calculator.
  """

  @valid_operators ["+", "-", "*", "/", "%"]
  @operator_regex ~r|^\s*(?<operator>[+\-*/%])\s*(?<operand>-?\d+(?:\.\d+)?)\s*$|

  @type operator :: String.t()
  @type operand :: float()
  @type result :: number()
  @type error_message :: String.t()
  @type calculation_result :: {:ok, result()}

  @doc """
  Parses the user input string and extracts the operator and operand.

  ## Parameters

    - `input`: A string representing the user's input (e.g., "+5", "-3.2").

  ## Returns

    - `{:ok, operator, operand}` on success.
    - `{:error, message}` if the input is invalid.
  """
  @spec parse_input(String.t()) :: {:ok, operator(), operand()} | {:error, error_message()}
  def parse_input(input) do
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
         "Invalid input. Use format: <operator><number> (e.g., +5, -3). " <>
           "Supported operators: #{Enum.join(@valid_operators, ", ")}."}
    end
  end

  @doc """
  Validates the operation to ensure it can be performed.

  ## Parameters

    - `operator`: A string representing the operator (e.g., "+", "-", "*", "/", "%").
    - `operand`: The operand as a float.

  ## Returns

    - `:ok` if the operation is valid.
    - `{:error, message}` if the operation is invalid (e.g., division by zero).
  """
  @spec validate_operation(operator(), operand()) :: :ok | {:error, error_message()}
  def validate_operation("/", operand) when operand == 0.0,
    do: {:error, "Cannot divide by zero."}

  def validate_operation("%", operand) when operand == 0.0,
    do: {:error, "Cannot modulo by zero."}

  def validate_operation(op, _) when op in @valid_operators, do: :ok

  def validate_operation(op, _),
    do:
      {:error,
       "Invalid operator '#{op}'. Supported operators: #{Enum.join(@valid_operators, ", ")}."}

  @doc """
  Performs the calculation based on the current result, operator, and operand.

  ## Parameters

    - `result`: The current result (number).
    - `operator`: A string representing the operator.
    - `operand`: The operand as a float.

  ## Returns

    - `{:ok, new_result}` where `new_result` is the result of the calculation.
  """
  @spec calculate(result(), operator(), operand()) :: {:ok, result()}
  def calculate(result, "+", operand), do: {:ok, result + operand}
  def calculate(result, "-", operand), do: {:ok, result - operand}
  def calculate(result, "*", operand), do: {:ok, result * operand}
  def calculate(result, "/", operand), do: {:ok, result / operand}

  def calculate(result, "%", operand),
    do: {:ok, rem(trunc(result), trunc(operand))}
end
