defmodule RockPaperScissors do
  @moduledoc """
  A simple CLI Rock, Paper, Scissors game that continues until 'exit' is input.
  """

  @valid_choices ["rock", "paper", "scissors"]
  @choice_emojis %{
    "rock" => "🪨",
    "paper" => "📄",
    "scissors" => "🔪"
  }

  @spec main() :: :ok
  def main do
    IO.puts("🎮 Welcome to Rock, Paper, Scissors! 🎮")
    run_game()
  end

  defp run_game do
    input =
      case IO.gets("Enter your choice (rock 🪨, paper 📄, scissors 🔪, or exit to quit): ") do
        :eof ->
          "exit"

        {:error, _reason} ->
          "exit"

        line ->
          String.trim(line) |> String.downcase()
      end

    case handle_input(input) do
      :exit ->
        IO.puts("👋 Thanks for playing! Goodbye! 🎮")

      :invalid ->
        IO.puts("❌ Invalid input. Please enter 'rock', 'paper', 'scissors', or 'exit'.")
        run_game()

      :continue ->
        run_game()
    end
  end

  defp handle_input("exit"), do: :exit

  defp handle_input(user_choice) do
    if user_choice in @valid_choices do
      computer_choice = Enum.random(@valid_choices)

      IO.puts("\nYou chose: #{user_choice} #{@choice_emojis[user_choice]}")
      IO.puts("Computer chose: #{computer_choice} #{@choice_emojis[computer_choice]}")
      determine_winner(user_choice, computer_choice)
      :continue
    else
      :invalid
    end
  end

  defp determine_winner(user_choice, computer_choice) do
    case {user_choice, computer_choice} do
      {choice, choice} ->
        IO.puts("🤝 It's a tie!")

      {"rock", "scissors"} ->
        IO.puts("🎉 You win! Rock beats scissors.")

      {"paper", "rock"} ->
        IO.puts("🎉 You win! Paper beats rock.")

      {"scissors", "paper"} ->
        IO.puts("🎉 You win! Scissors beats paper.")

      {"rock", "paper"} ->
        IO.puts("💻 Computer wins! Paper beats rock.")

      {"paper", "scissors"} ->
        IO.puts("💻 Computer wins! Scissors beats paper.")

      {"scissors", "rock"} ->
        IO.puts("💻 Computer wins! Rock beats scissors.")
    end
  end
end
