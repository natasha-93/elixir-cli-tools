defmodule RockPaperScissors do
  @moduledoc """

  This module allows a user to play Rock, Paper, Scissors against the computer.
  The game continues until the user types `exit` to quit.

  """

  # Ordered list of choices with their corresponding emojis
  @choices [
    {"rock", "🪨"},
    {"paper", "📄"},
    {"scissors", "🔪"}
  ]

  @spec main() :: :ok
  def main do
    IO.puts("Welcome to Rock, Paper, Scissors!")
    run_game()
  end

  # Main game loop
  @spec run_game() :: :ok
  defp run_game do
    input =
      case IO.gets("Enter your choice (rock, paper, scissors, or exit to quit): ") do
        :eof ->
          "exit"

        {:error, _reason} ->
          "exit"

        line ->
          String.trim(line) |> String.downcase()
      end

    case handle_input(input) do
      :exit ->
        IO.puts("Thanks for playing! Goodbye!")

      :invalid ->
        IO.puts("Invalid input. Please enter 'rock', 'paper', 'scissors', or 'exit'.")
        run_game()

      :continue ->
        run_game()
    end
  end

  # Handle user input
  @spec handle_input(String.t()) :: :exit | :invalid | :continue
  defp handle_input("exit"), do: :exit

  defp handle_input(user_choice) do
    if choice_valid?(user_choice) do
      computer_choice = Enum.random(get_choice_names())

      IO.puts("\nYou chose: #{user_choice} #{get_emoji(user_choice)}")
      IO.puts("Computer chose: #{computer_choice} #{get_emoji(computer_choice)}")
      determine_winner(user_choice, computer_choice)
      :continue
    else
      :invalid
    end
  end

  # Check if the user's choice is valid
  @spec choice_valid?(String.t()) :: boolean()
  defp choice_valid?(choice) do
    Enum.any?(@choices, fn {key, _} -> key == choice end)
  end

  # Get list of choice names
  @spec get_choice_names() :: [String.t()]
  defp get_choice_names do
    Enum.map(@choices, fn {key, _} -> key end)
  end

  # Retrieve emoji for a given choice
  @spec get_emoji(String.t()) :: String.t()
  defp get_emoji(choice) do
    case Enum.find(@choices, fn {key, _} -> key == choice end) do
      {_, emoji} -> emoji
      nil -> ""
    end
  end

  # Determine the winner based on choice indexes
  @spec determine_winner(String.t(), String.t()) :: :tie | :user_win | :computer_win
  defp determine_winner(user_choice, computer_choice) do
    user_index = get_choice_index(user_choice)
    computer_index = get_choice_index(computer_choice)
    choices_count = length(@choices)

    cond do
      user_index == computer_index ->
        IO.puts("It's a tie!")

      Integer.mod(user_index - computer_index, choices_count) == 1 ->
        IO.puts(
          "You win! #{user_choice} #{get_emoji(user_choice)} beats #{computer_choice} #{get_emoji(computer_choice)}."
        )

      true ->
        IO.puts(
          "Computer wins! #{computer_choice} #{get_emoji(computer_choice)} beats #{user_choice} #{get_emoji(user_choice)}."
        )
    end
  end

  # Get the index of a choice in the ordered list
  @spec get_choice_index(String.t()) :: integer() | nil
  defp get_choice_index(choice) do
    Enum.find_index(@choices, fn {key, _} -> key == choice end)
  end
end
