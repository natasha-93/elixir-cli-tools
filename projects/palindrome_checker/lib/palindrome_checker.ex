defmodule PalindromeChecker do
 @moduledoc """
  A simple module to check if a given input is a palindrome.
  """

  def main(args) do
    input = Enum.join(args, " ")
    if is_palindrome?(input) do
      IO.puts("#{input} is a palindrome!")
    else
      IO.puts("#{input} is not a palindrome.")
    end
  end


  defp is_palindrome?(string) do
    cleaned = String.downcase(String.replace(string, ~r/[^a-z0-9]/i, ""))
    cleaned == String.reverse(cleaned)
  end
end
