defmodule RockPaperScissors.Score do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scores" do
    field :wins, :integer, default: 0
    field :losses, :integer, default: 0
    field :ties, :integer, default: 0

    timestamps()
  end

  def changeset(score, attrs) do
    score
    |> cast(attrs, [:wins, :losses, :ties])
    |> validate_required([:wins, :losses, :ties])
    |> validate_number(:wins, greater_than_or_equal_to: 0)
    |> validate_number(:losses, greater_than_or_equal_to: 0)
    |> validate_number(:ties, greater_than_or_equal_to: 0)
  end
end
