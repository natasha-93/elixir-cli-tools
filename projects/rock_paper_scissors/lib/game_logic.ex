defmodule RockPaperScissors.Game do
  @moduledoc """
  Game logic for Rock, Paper, Scissors.
  """

  alias RockPaperScissors.{Repo, Score}

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

  @spec update_score(result(), score(), boolean()) :: score()
  def update_score(result, current_score, use_db \\ true)

  def update_score(result, current_score, false) do
    # For test environment, use the provided score
    case result do
      :tie -> %{current_score | ties: current_score.ties + 1}
      :user_win -> %{current_score | wins: current_score.wins + 1}
      :computer_win -> %{current_score | losses: current_score.losses + 1}
    end
  end

  def update_score(result, _current_score, true) do
    # For non-test environment, use the database
    db_score = case Repo.one(Score) do
      nil -> %Score{}
      score -> score
    end

    {wins, losses, ties} = case result do
      :tie -> {db_score.wins, db_score.losses, db_score.ties + 1}
      :user_win -> {db_score.wins + 1, db_score.losses, db_score.ties}
      :computer_win -> {db_score.wins, db_score.losses + 1, db_score.ties}
    end

    updated_score = Ecto.Changeset.change(db_score, %{
      wins: wins,
      losses: losses,
      ties: ties
    })

    case Repo.insert_or_update(updated_score) do
      {:ok, score} -> %{wins: score.wins, losses: score.losses, ties: score.ties}
      {:error, _} -> %{wins: wins, losses: losses, ties: ties}
    end
  end

  @spec get_choice_index(choice_name()) :: non_neg_integer() | nil
  defp get_choice_index(choice) do
    Enum.find_index(@choices, fn {key, _} -> key == choice end)
  end
end
