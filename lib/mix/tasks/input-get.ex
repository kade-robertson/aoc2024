defmodule Mix.Tasks.Input.Get do
  @moduledoc "Fetches input from AoC website"
  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    HTTPoison.start()
    Dotenv.load!()

    AOC2024.Runner.problems()
    |> Enum.each(fn problem -> problem.input() end)

    :ok
  end
end
