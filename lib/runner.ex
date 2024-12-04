defmodule AOC2024.Runner do
  def problems() do
    [
      AOC2024.Day01,
      AOC2024.Day02,
      AOC2024.Day03,
      AOC2024.Day04
    ]
  end

  def warmup(input, parse, solve) do
    Enum.each(1..5, fn _ -> input |> parse.() |> solve.() end)
  end

  def run_problem_part(input, parse, solve) do
    warmup(input, parse, solve)

    {parse_time, parsed} = :timer.tc(fn -> input |> parse.() end)
    {solve_time, solved} = :timer.tc(fn -> parsed |> solve.() end)

    Integer.to_string(solved) <>
      " (parse: " <>
      Integer.to_string(parse_time) <> "µs, solve: " <> Integer.to_string(solve_time) <> "µs)"
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
