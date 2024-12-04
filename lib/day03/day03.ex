defmodule AOC2024.Day03 do
  def input(), do: AOC2024.Input.read("lib/day03/input.txt")

  def name(), do: "Day 3: Mull It Over"

  @type inputPt1 :: list({integer(), integer()})
  @type inputPt2 :: list({integer(), integer()} | boolean())
  @type outputPt1 :: integer()
  @type outputPt2 :: integer()

  @spec parsePt1(String.t()) :: inputPt1 | {:error, any()}
  def parsePt1(input) do
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

  @spec parsePt2(String.t()) :: inputPt2 | {:error, any()}
  def parsePt2(input) do
    Regex.scan(~r/(mul\((\d+),(\d+)\))|(do\(\))|(don't\(\))/, input)
    |> Enum.map(fn l -> Enum.drop(l, 2) end)
    |> Enum.map(&categorize/1)
  end

  @spec solvePt1(inputPt1()) :: outputPt1()
  def solvePt1(input) do
    input |> Enum.map(fn {a, b} -> a * b end) |> Enum.sum()
  end

  @spec solvePt2(inputPt2()) :: outputPt2()
  def solvePt2(input) do
    {_, result} =
      Enum.reduce(input, {true, 0}, fn
        {a, b}, {state, acc} -> {state, if(state, do: acc + a * b, else: acc)}
        false, {_, acc} -> {false, acc}
        true, {_, acc} -> {true, acc}
      end)

    result
  end
end
