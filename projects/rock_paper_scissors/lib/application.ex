defmodule RockPaperScissors.Application do
  use Application

  def start(_type, _args) do
    children = [
      {RockPaperScissors.Repo, []}
    ]

    opts = [strategy: :one_for_one, name: RockPaperScissors.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
