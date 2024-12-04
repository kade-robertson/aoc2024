import Combine.Parsers.Base
import Combine.Parsers.Text

defmodule AOC2024.Day02 do
  def input(), do: AOC2024.Input.read("lib/day02/input.txt")

  def name(), do: "Day 2: Red-Nosed Reports"

  @type input_part_1 :: list(list(integer()))
  @type input_part_2 :: list(list(integer()))
  @type output_part_1 :: integer()
  @type output_part_2 :: integer()

  defp parse_line(input),
    do: Combine.parse(input, sep_by1(sep_by1(integer(), spaces()), newline())) |> List.first()

  @spec parse_part_1(String.t()) :: input_part_1 | {:error, any()}
  def parse_part_1(input) do
    input
    |> parse_line()
  end

  @spec parse_part_2(String.t()) :: input_part_2 | {:error, any()}
  def parse_part_2(input) do
    input |> parse_part_1()
  end

  def is_pair_decreasing({a, b}),
    do: a > b && a - b >= 1 && a - b <= 3

  def is_pair_increasing({a, b}),
    do: a < b && b - a >= 1 && b - a <= 3

  def is_increasing(pairs),
    do: pairs |> Enum.all?(&is_pair_increasing/1)

  def is_decreasing(pairs),
    do: pairs |> Enum.all?(&is_pair_decreasing/1)

  @spec solve_part_1(input_part_1()) :: output_part_1()
  def solve_part_1(input) do
    input
    |> Enum.map(fn l -> Enum.zip(l, Enum.drop(l, 1)) end)
    |> Enum.filter(fn l -> is_increasing(l) || is_decreasing(l) end)
    |> Enum.count()
  end

  def check_combinations(option) do
    Enum.map(0..(Enum.count(option) - 1), fn i ->
      Enum.slice(option, 0, i) ++ Enum.slice(option, i + 1, Enum.count(option) - i - 1)
    end)
    |> Enum.map(fn l -> Enum.zip(l, Enum.drop(l, 1)) end)
    |> Enum.any?(fn l -> is_increasing(l) || is_decreasing(l) end)
  end

  @spec solve_part_2(input_part_2()) :: output_part_2()
  def solve_part_2(input) do
    input
    |> Enum.count(&check_combinations/1)
  end
end
