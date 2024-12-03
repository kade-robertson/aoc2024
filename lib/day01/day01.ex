import Combine.Parsers.Base
import Combine.Parsers.Text

defmodule AOC2024.Day01 do
  def input(), do: AOC2024.Input.read("lib/day01/input.txt")

  def name(), do: "Day 1: Historian Hysteria"

  @type inputPt1 :: list({integer(), integer()})
  @type inputPt2 :: list({integer(), integer()})
  @type outputPt1 :: integer()
  @type outputPt2 :: integer()

  defp line_parser, do: pipe([integer(), ignore(spaces()), integer()], &Function.identity/1)

  defp parse_line(input),
    do: Combine.parse(input, sep_by(line_parser(), newline())) |> List.first()

  @spec parsePt1(String.t()) :: inputPt1 | {:error, any()}
  def parsePt1(input) do
    input
    |> parse_line
    |> Enum.map(fn [a, b] -> {a, b} end)
  end

  @spec parsePt2(String.t()) :: inputPt2 | {:error, any()}
  def parsePt2(input) do
    input |> parsePt1()
  end

  @spec solvePt1(inputPt1()) :: outputPt1()
  def solvePt1(input) do
    input
    |> Enum.unzip()
    |> Tuple.to_list()
    |> Enum.map(fn list -> Enum.sort(list) end)
    |> Enum.zip()
    |> Enum.map(fn {a, b} -> abs(b - a) end)
    |> Enum.sum()
  end

  @spec solvePt2(inputPt2()) :: outputPt2()
  def solvePt2(input) do
    [first, second] =
      input
      |> Enum.unzip()
      |> Tuple.to_list()

    second_map =
      second |> Enum.reduce(%{}, fn x, acc -> Map.put(acc, x, Map.get(acc, x, 0) + 1) end)

    first |> Enum.map(fn x -> Map.get(second_map, x, 0) * x end) |> Enum.sum()
  end
end
