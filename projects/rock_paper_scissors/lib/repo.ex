defmodule RockPaperScissors.Repo do
  use Ecto.Repo,
    otp_app: :rock_paper_scissors,
    adapter: Ecto.Adapters.SQLite3
end
