# RockPaperScissors

A simple Command-Line Interface (CLI) game of Rock, Paper, Scissors.

## Features

    - **User Input**: Prompts the user to enter their choice (`rock`, `paper`, `scissors`, or `exit`).
    - **Computer Choice**: Randomly selects a choice for the computer.
    - **Winner Determination**: Determines the winner based on the standard rules:
      - Rock beats Scissors
      - Paper beats Rock
      - Scissors beats Paper
    - **Error Handling**: Handles invalid inputs gracefully by prompting the user again.
    - **Emojis**: Displays emojis alongside choices for an enhanced user experience.
    - **Scoring**: Keeps track of scores during a session

## Example Interaction

      ```
      Welcome to Rock, Paper, Scissors!
      Enter your choice (rock, paper, scissors, or exit to quit): rock

      You chose: rock 🪨
      Computer chose: scissors 🔪
      You win! rock 🪨 beats scissors 🔪.

      Enter your choice (rock, paper, scissors, or exit to quit): exit
      Thanks for playing! Goodbye!
      ```

## Future enhancements

    - Add a "best of X rounds" mode where the game ends after a certain number of rounds.
    - Store scores in a file for persistent tracking across sessions.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `rock_paper_scissors` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:rock_paper_scissors, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/rock_paper_scissors>.
