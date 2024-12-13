defmodule RockPaperScissors.GameTest do
  use ExUnit.Case, async: true
  alias RockPaperScissors.Game

  describe "choice_valid?/1" do
    test "validates correct choices" do
      assert Game.choice_valid?("rock")
      assert Game.choice_valid?("paper")
      assert Game.choice_valid?("scissors")
    end

    test "invalidates incorrect choices" do
      refute Game.choice_valid?("lizard")
      refute Game.choice_valid?("")
    end
  end

  describe "determine_winner/2" do
    test "correctly determines ties" do
      assert Game.determine_winner(:rock, :rock) == :tie
      assert Game.determine_winner(:paper, :paper) == :tie
    end

    test "determines user wins" do
      assert Game.determine_winner(:rock, :scissors) == :user_win
      assert Game.determine_winner(:scissors, :paper) == :user_win
    end

    test "determines computer wins" do
      assert Game.determine_winner(:rock, :paper) == :computer_win
      assert Game.determine_winner(:scissors, :rock) == :computer_win
    end
  end

  describe "update_score/2" do
    test "updates scores correctly for ties" do
      initial_score = %{wins: 0, losses: 0, ties: 0}
      assert Game.update_score(:tie, initial_score, false) == %{wins: 0, losses: 0, ties: 1}
    end

    test "updates scores correctly for user wins" do
      initial_score = %{wins: 0, losses: 0, ties: 0}
      assert Game.update_score(:user_win, initial_score, false) == %{wins: 1, losses: 0, ties: 0}
    end

    test "updates scores correctly for computer wins" do
      initial_score = %{wins: 0, losses: 0, ties: 0}
      assert Game.update_score(:computer_win, initial_score, false) == %{wins: 0, losses: 1, ties: 0}
    end
  end
end
