defmodule AOC2024.Day03 do
  def input(), do: AOC2024.Input.read("lib/day03/input.txt")

  def name(), do: "Day 3: Mull It Over"

  @type input_part_1 :: list({integer(), integer()})
  @type input_part_2 :: list({integer(), integer()} | boolean())
  @type output_part_1 :: integer()
  @type output_part_2 :: integer()

  @spec parse_part_1(String.t()) :: input_part_1
  def parse_part_1(input) do
    Regex.scan(~r/mul\((\d+),(\d+)\)/, input)
    |> Enum.map(fn l -> Enum.drop(l, 1) end)
    |> Enum.map(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)
  end

  def categorize(match) do
    case Enum.at(match, -1) do
      "do()" -> true
      "don't()" -> false
      _ -> {String.to_integer(Enum.at(match, 0)), String.to_integer(Enum.at(match, 1))}
    end
  end

  @spec parse_part_2(String.t()) :: input_part_2
  def parse_part_2(input) do
    Regex.scan(~r/(mul\((\d+),(\d+)\))|(do\(\))|(don't\(\))/, input)
    |> Enum.map(fn l -> Enum.drop(l, 2) end)
    |> Enum.map(&categorize/1)
  end

  @spec solve_part_1(input_part_1()) :: output_part_1()
  def solve_part_1(input) do
    input |> Enum.map(fn {a, b} -> a * b end) |> Enum.sum()
  end

  @spec solve_part_2(input_part_2()) :: output_part_2()
  def solve_part_2(input) do
    {_, result} =
      Enum.reduce(input, {true, 0}, fn
        {a, b}, {state, acc} -> {state, if(state, do: acc + a * b, else: acc)}
        false, {_, acc} -> {false, acc}
        true, {_, acc} -> {true, acc}
      end)

    result
  end
end
