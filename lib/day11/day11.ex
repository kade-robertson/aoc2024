import Combine.Parsers.Base
import Combine.Parsers.Text

defmodule AOC2024.Day11 do
  use Memoize
  def input(), do: AOC2024.Input.read("lib/day11/input.txt")

  def name(), do: "Day 11: Plutonian Pebbles"

  @type input_part_1 :: any()
  @type input_part_2 :: any()
  @type output_part_1 :: integer()
  @type output_part_2 :: integer()

  @spec parse_part_1(String.t()) :: input_part_1
  def parse_part_1(input) do
    input |> Combine.parse(sep_by1(integer(), spaces())) |> hd
  end

  @spec split_stone(integer()) :: {[integer(), ...], 1}
  defmemo split_stone(number) do
    digits = number |> Integer.digits()
    {left_half, right_half} = digits |> Enum.split(Enum.count(digits) |> Kernel.div(2))
    [Integer.undigits(left_half), Integer.undigits(right_half)]
  end

  defmemo even_digits?(number) do
    number |> Integer.digits() |> Enum.count() |> Kernel.rem(2) == 0
  end

  defmemo(simulate_blink(_, steps) when steps < 1, do: 1)
  defmemo(simulate_blink(0, steps), do: simulate_blink(1, steps - 1))

  defmemo simulate_blink(value, steps) do
    if even_digits?(value) do
      stones = split_stone(value)
      Enum.reduce(stones, 0, fn v, acc -> acc + simulate_blink(v, steps - 1) end)
    else
      simulate_blink(value * 2024, steps - 1)
    end
  end

  @spec solve_part_1(input_part_1()) :: output_part_1()
  def solve_part_1(input) do
    input |> Enum.map(fn v -> simulate_blink(v, 25) end) |> Enum.sum()
  end

  @spec parse_part_2(String.t()) :: input_part_2
  def parse_part_2(input) do
    input |> parse_part_1()
  end

  @spec solve_part_2(input_part_2()) :: output_part_2()
  def solve_part_2(input) do
    input |> Enum.map(fn v -> simulate_blink(v, 75) end) |> Enum.sum()
  end
end
