defmodule RockPaperScissors.Repo.Migrations.CreateScores do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :wins, :integer, default: 0
      add :losses, :integer, default: 0
      add :ties, :integer, default: 0

      timestamps()
    end
  end
end
