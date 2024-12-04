import Combine.Parsers.Base
import Combine.Parsers.Text

defmodule AOC2024.Day01 do
  def input(), do: AOC2024.Input.read("lib/day01/input.txt")

  def name(), do: "Day 1: Historian Hysteria"

  @type input_part_1 :: list({integer(), integer()})
  @type input_part_2 :: list({integer(), integer()})
  @type output_part_1 :: integer()
  @type output_part_2 :: integer()

  defp line_parser, do: pipe([integer(), ignore(spaces()), integer()], &Function.identity/1)

  defp parse_line(input),
    do: Combine.parse(input, sep_by(line_parser(), newline())) |> List.first()

  @spec parse_part_1(String.t()) :: input_part_1 | {:error, any()}
  def parse_part_1(input) do
    input
    |> parse_line
    |> Enum.map(fn [a, b] -> {a, b} end)
  end

  @spec parse_part_2(String.t()) :: input_part_2 | {:error, any()}
  def parse_part_2(input) do
    input |> parse_part_1()
  end

  @spec solve_part_1(input_part_1()) :: output_part_1()
  def solve_part_1(input) do
    input
    |> Enum.unzip()
    |> Tuple.to_list()
    |> Enum.map(fn list -> Enum.sort(list) end)
    |> Enum.zip()
    |> Enum.map(fn {a, b} -> abs(b - a) end)
    |> Enum.sum()
  end

  @spec solve_part_2(input_part_2()) :: output_part_2()
  def solve_part_2(input) do
    [first, second] =
      input
      |> Enum.unzip()
      |> Tuple.to_list()

    second_map =
      second |> Enum.reduce(%{}, fn x, acc -> Map.put(acc, x, Map.get(acc, x, 0) + 1) end)

    first |> Enum.map(fn x -> Map.get(second_map, x, 0) * x end) |> Enum.sum()
  end
end
