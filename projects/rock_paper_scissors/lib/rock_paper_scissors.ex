defmodule RockPaperScissors do
  @moduledoc """
  Entry point for the Rock, Paper, Scissors game.
  """

  alias RockPaperScissors.CLI

  def main do
    CLI.start_game()
  end
end
