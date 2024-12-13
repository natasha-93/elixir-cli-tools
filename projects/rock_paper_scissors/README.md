# RockPaperScissors

A simple Command-Line Interface (CLI) game of Rock, Paper, Scissors with persistent score tracking.

## Features

- **User Input**: Prompts the user to enter their choice (`rock`, `paper`, `scissors`, or `exit`).
- **Computer Choice**: Randomly selects a choice for the computer.
- **Winner Determination**: Determines the winner based on the standard rules:
  - Rock beats Scissors
  - Paper beats Rock
  - Scissors beats Paper
- **Error Handling**: Handles invalid inputs gracefully by prompting the user again.
- **Emojis**: Displays emojis alongside choices for an enhanced user experience.
- **Persistent Scoring**: Keeps track of scores across sessions using SQLite:
  - Wins, losses, and ties are stored persistently
  - Scores are automatically saved after each game
  - Scores persist between game sessions

## Example Interaction

```
Welcome to Rock, Paper, Scissors!
Enter your choice (rock, paper, scissors, or exit to quit): rock

You chose: rock 🪨
Computer chose: scissors 🔪
You win! rock 🪨 beats scissors 🔪.

Current Score:
Wins: 1, Losses: 0, Ties: 0

Enter your choice (rock, paper, scissors, or exit to quit): exit
Thanks for playing! Goodbye!
```

## Technical Details

The game uses SQLite for persistent score storage:

- Scores are stored in a local SQLite database (`rock_paper_scissors.sqlite3`)
- The database automatically maintains win/loss/tie statistics
- Score tracking is handled through Ecto for reliable database operations

## Future Enhancements

- Add a "best of X rounds" mode where the game ends after a certain number of rounds
- Add player profiles to track multiple players' scores separately
- Add statistics viewing commands to see detailed game history

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
