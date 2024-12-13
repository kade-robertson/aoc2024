defmodule AOC2024.Runner do
  def problems() do
    [
      AOC2024.Day01,
      AOC2024.Day02,
      AOC2024.Day03,
      AOC2024.Day04,
      AOC2024.Day05,
      AOC2024.Day06,
      AOC2024.Day07,
      AOC2024.Day08,
      AOC2024.Day09,
      AOC2024.Day10,
      AOC2024.Day11,
      AOC2024.Day12
    ]
  end

  def warmup(input, parse, solve) do
    input |> parse.() |> solve.()
  end

  def time_fmt(t) when t < 1000, do: Integer.to_string(t) <> "µs"

  def time_fmt(t) when t < 1_000_000,
    do: :erlang.float_to_binary(t / 1_000.0, decimals: 2) <> "ms"

  def time_fmt(t), do: :erlang.float_to_binary(t / 1_000_000.0, decimals: 2) <> "s"

  def run_problem_part(input, parse, solve) do
    warmup(input, parse, solve)
    Memoize.Cache.invalidate()

    {parse_time, parsed} = :timer.tc(fn -> input |> parse.() end)
    {solve_time, solved} = :timer.tc(fn -> parsed |> solve.() end)

    Integer.to_string(solved) <>
      " (parse: " <>
      time_fmt(parse_time) <> ", solve: " <> time_fmt(solve_time) <> ")"
  end

  def run_problem(problem) do
    input = problem.input()

    IO.puts(problem.name())

    IO.puts(
      " - Part 1: " <>
        run_problem_part(input, &problem.parse_part_1/1, &problem.solve_part_1/1)
    )

    IO.puts(
      " - Part 2: " <>
        run_problem_part(input, &problem.parse_part_2/1, &problem.solve_part_2/1)
    )
  end

  def run_problems() do
    problems() |> Enum.each(fn problem -> problem |> run_problem end)
  end
end
