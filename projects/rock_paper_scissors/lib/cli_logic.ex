defmodule RockPaperScissors.CLI do
  @moduledoc """
  CLI interface for Rock, Paper, Scissors.
  """

  alias RockPaperScissors.Game

  @spec start_game() :: :ok
  def start_game do
    IO.puts("Welcome to Rock, Paper, Scissors!")
    initial_score = %{wins: 0, losses: 0, ties: 0}
    run_game(initial_score)
  end

  @spec run_game(Game.score()) :: :ok
  defp run_game(score) do
    input = get_user_input()

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

  @spec get_user_input() :: String.t()
  defp get_user_input do
    case IO.gets("Enter your choice (rock, paper, scissors, or exit to quit): ") do
      :eof -> "exit"
      {:error, _reason} -> "exit"
      line -> String.trim(line) |> String.downcase()
    end
  end

  @spec handle_input(String.t(), Game.score()) :: :exit | {:continue, Game.score()}
  defp handle_input("exit", _score), do: :exit

  defp handle_input(user_choice, score) do
    if Game.choice_valid?(user_choice) do
      user_choice_atom = String.to_existing_atom(user_choice)
      computer_choice = Enum.random(Game.get_choices()) |> elem(0)

      IO.puts("\nYou chose: #{user_choice_atom} #{Game.get_emoji(user_choice_atom)}")
      IO.puts("Computer chose: #{computer_choice} #{Game.get_emoji(computer_choice)}")

      result = Game.determine_winner(user_choice_atom, computer_choice)
      updated_score = Game.update_score(result, score)

      display_result(result)
      display_scores(updated_score)

      {:continue, updated_score}
    else
      IO.puts("Invalid input. Please enter 'rock', 'paper', 'scissors', or 'exit'.")
      {:continue, score}
    end
  end

  @spec display_result(Game.result()) :: :ok
  defp display_result(:tie), do: IO.puts("It's a tie!")
  defp display_result(:user_win), do: IO.puts("You win!")
  defp display_result(:computer_win), do: IO.puts("Computer wins!")

  @spec display_scores(Game.score()) :: :ok
  defp display_scores(%{wins: wins, losses: losses, ties: ties}) do
    IO.puts("""
    Current Scores:
      Wins: #{wins}
      Losses: #{losses}
      Ties: #{ties}
    """)
  end
end
