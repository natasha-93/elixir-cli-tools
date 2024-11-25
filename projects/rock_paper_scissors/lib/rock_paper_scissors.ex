defmodule RockPaperScissors do
  @moduledoc """
  A simple CLI Rock, Paper, Scissors game with emojis and score tracking.
  """

  @choices [
    {"rock", "🪨"},
    {"paper", "📄"},
    {"scissors", "🔪"}
  ]

  @spec main() :: :ok
  def main do
    IO.puts("Welcome to Rock, Paper, Scissors!")
    initial_score = %{wins: 0, losses: 0, ties: 0}
    run_game(initial_score)
  end

  @spec run_game(%{wins: integer(), losses: integer(), ties: integer()}) :: :ok
  defp run_game(score) do
    input =
      case IO.gets("Enter your choice (rock, paper, scissors, or exit to quit): ") do
        :eof ->
          "exit"

        {:error, _reason} ->
          "exit"

        line ->
          String.trim(line) |> String.downcase()
      end

    case handle_input(input, score) do
      :exit ->
        IO.puts("\nFinal Scores:")
        display_scores(score)
        IO.puts("Thanks for playing! Goodbye!")
        :ok

      {:continue, updated_score} ->
        run_game(updated_score)
    end
  end


  @spec handle_input(String.t(), %{wins: integer(), losses: integer(), ties: integer()}) ::
          :exit | {:continue, %{wins: integer(), losses: integer(), ties: integer()}}
  defp handle_input("exit", _score), do: :exit

  defp handle_input(user_choice, score) do
    if choice_valid?(user_choice) do
      computer_choice = Enum.random(get_choice_names())

      IO.puts("\nYou chose: #{user_choice} #{get_emoji(user_choice)}")
      IO.puts("Computer chose: #{computer_choice} #{get_emoji(computer_choice)}")

      result = determine_winner(user_choice, computer_choice)
      updated_score = update_score(result, score)

      display_result(result)
      display_scores(updated_score)

      {:continue, updated_score}
    else
      IO.puts("Invalid input. Please enter 'rock', 'paper', 'scissors', or 'exit'.")
      {:continue, score}
    end
  end

  @spec update_score(:tie | :user_win | :computer_win, %{wins: integer(), losses: integer(), ties: integer()}) ::
          %{wins: integer(), losses: integer(), ties: integer()}
  defp update_score(:tie, %{wins: wins, losses: losses, ties: ties}) do
    %{wins: wins, losses: losses, ties: ties + 1}
  end

  defp update_score(:user_win, %{wins: wins, losses: losses, ties: ties}) do
    %{wins: wins + 1, losses: losses, ties: ties}
  end

  defp update_score(:computer_win, %{wins: wins, losses: losses, ties: ties}) do
    %{wins: wins, losses: losses + 1, ties: ties}
  end

  @spec display_result(:tie | :user_win | :computer_win) :: :ok
  defp display_result(:tie) do
    IO.puts("It's a tie!")
  end

  defp display_result(:user_win) do
    IO.puts("You win!")
  end

  defp display_result(:computer_win) do
    IO.puts("Computer wins!")
  end

  @spec display_scores(%{wins: integer(), losses: integer(), ties: integer()}) :: :ok
  defp display_scores(%{wins: wins, losses: losses, ties: ties}) do
    IO.puts("""
    Current Scores:
      Wins: #{wins}
      Losses: #{losses}
      Ties: #{ties}
    """)
  end

  @spec determine_winner(String.t(), String.t()) :: :tie | :user_win | :computer_win
  defp determine_winner(user_choice, computer_choice) do
    user_index = get_choice_index(user_choice)
    computer_index = get_choice_index(computer_choice)
    choices_count = length(@choices)

    cond do
      user_index == computer_index ->
        :tie

      Integer.mod(user_index - computer_index, choices_count) == 1 ->
        :user_win

      true ->
        :computer_win
    end
  end

  @spec choice_valid?(String.t()) :: boolean()
  defp choice_valid?(choice) do
    Enum.any?(@choices, fn {key, _} -> key == choice end)
  end

  @spec get_emoji(String.t()) :: String.t()
  defp get_emoji(choice) do
    case Enum.find(@choices, fn {key, _} -> key == choice end) do
      {_, emoji} -> emoji
      nil -> ""
    end
  end

  @spec get_choice_index(String.t()) :: integer() | nil
  defp get_choice_index(choice) do
    Enum.find_index(@choices, fn {key, _} -> key == choice end)
  end

  @spec get_choice_names() :: [String.t()]
  defp get_choice_names do
    Enum.map(@choices, fn {key, _} -> key end)
  end
end
