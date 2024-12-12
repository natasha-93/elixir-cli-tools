defmodule RockPaperScissors.Game do
  @moduledoc """
  Game logic for Rock, Paper, Scissors.
  """

  @type choice_name :: :rock | :paper | :scissors
  @type result :: :tie | :user_win | :computer_win
  @type score :: %{wins: non_neg_integer(), losses: non_neg_integer(), ties: non_neg_integer()}

  @choices [
    {:rock, "🪨"},
    {:paper, "📄"},
    {:scissors, "🔪"}
  ]

  @spec get_choices() :: [{choice_name(), String.t()}]
  def get_choices, do: @choices

  @spec choice_valid?(String.t()) :: boolean()
  def choice_valid?(choice) do
    Enum.any?(@choices, fn {key, _} -> Atom.to_string(key) == choice end)
  end

  @spec get_emoji(choice_name()) :: String.t()
  def get_emoji(choice) do
    case Enum.find(@choices, fn {key, _} -> key == choice end) do
      {_, emoji} -> emoji
      nil -> ""
    end
  end

  @spec determine_winner(choice_name(), choice_name()) :: result()
  def determine_winner(user_choice, computer_choice) do
    user_index = get_choice_index(user_choice)
    computer_index = get_choice_index(computer_choice)
    choices_count = length(@choices)

    cond do
      user_index == computer_index -> :tie
      Integer.mod(user_index - computer_index, choices_count) == 1 -> :user_win
      true -> :computer_win
    end
  end

  @spec update_score(result(), score()) :: score()
  def update_score(:tie, %{wins: wins, losses: losses, ties: ties}) do
    %{wins: wins, losses: losses, ties: ties + 1}
  end

  def update_score(:user_win, %{wins: wins, losses: losses, ties: ties}) do
    %{wins: wins + 1, losses: losses, ties: ties}
  end

  def update_score(:computer_win, %{wins: wins, losses: losses, ties: ties}) do
    %{wins: wins, losses: losses + 1, ties: ties}
  end

  @spec get_choice_index(choice_name()) :: non_neg_integer() | nil
  defp get_choice_index(choice) do
    Enum.find_index(@choices, fn {key, _} -> key == choice end)
  end
end
