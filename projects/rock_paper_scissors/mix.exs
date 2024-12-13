defmodule RockPaperScissors.MixProject do
  use Mix.Project

  def project do
    [
      app: :rock_paper_scissors,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {RockPaperScissors.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false},
      {:ecto_sql, "~> 3.9"},
      {:ecto_sqlite3, "~> 0.9.0"}
    ]
  end
end
