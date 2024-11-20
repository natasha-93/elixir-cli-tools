defmodule TerminalCalculator.MixProject do
  use Mix.Project

  def project do
    [
      app: :terminal_calculator,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: TerminalCalculator]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end
end