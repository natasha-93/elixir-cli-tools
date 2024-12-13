import Config

config :rock_paper_scissors, ecto_repos: [RockPaperScissors.Repo]

config :rock_paper_scissors, RockPaperScissors.Repo,
  database: "rock_paper_scissors.sqlite3",
  pool_size: 5,
  timeout: 15_000
