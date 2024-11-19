defmodule PalindromeChecker do
 @moduledoc """
  A simple module to check if a given input is a palindrome.
  """

  def main(args) do
    input = Enum.join(args, " ")
    input
    |> clean_input()
    |> check_palindrome(input)
  end

  defp clean_input(string) do
    string
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9]/i, "")
  end


  defp check_palindrome(cleaned, original) do
    message =
      if cleaned == String.reverse(cleaned) do
        "#{original} is a palindrome!"
      else
        "#{original} is not a palindrome."
      end

    IO.puts(message)
  end
end
