import Combine.Parsers.Base
import Combine.Parsers.Text

defmodule AOC2024.Day07 do
  def input(), do: AOC2024.Input.read("lib/day07/input.txt")

  def name(), do: "Day 7: Bridge Repair"

  @type input_part_1 :: [{integer(), [integer()]}]
  @type input_part_2 :: [{integer(), [integer()]}]
  @type output_part_1 :: integer()
  @type output_part_2 :: integer()

  @spec parse_part_1(String.t()) :: input_part_1 | {:error, any()}
  def parse_part_1(input) do
    input
    |> Combine.parse(
      sep_by1(
        pipe(
          [integer(), ignore(char(":")), ignore(spaces()), sep_by1(integer(), spaces())],
          &Function.identity/1
        ),
        newline()
      )
    )
    |> hd
    |> Enum.map(&List.to_tuple/1)
  end

  @spec can_be_evaluated_to?(integer(), [integer()], integer()) :: boolean()
  def can_be_evaluated_to?(target, [], current), do: current == target

  def can_be_evaluated_to?(target, numbers, current) do
    {[head], rest} = Enum.split(numbers, 1)

    if current == 0 do
      can_be_evaluated_to?(target, rest, head)
    else
      can_be_evaluated_to?(target, rest, current + head) or
        can_be_evaluated_to?(target, rest, current * head)
    end
  end

  @spec solve_part_1(input_part_1()) :: output_part_1()
  def solve_part_1(input) do
    input
    |> Enum.reduce(0, fn {target, numbers}, acc ->
      if can_be_evaluated_to?(target, numbers, 0) do
        acc + target
      else
        acc
      end
    end)
  end

  @spec parse_part_2(String.t()) :: input_part_2 | {:error, any()}
  def parse_part_2(input) do
    input |> parse_part_1()
  end

  @spec can_be_evaluated_to_pt2?(integer(), [integer()], integer()) :: boolean()
  def can_be_evaluated_to_pt2?(target, [], current), do: current == target

  def can_be_evaluated_to_pt2?(target, numbers, current) do
    {[head], rest} = Enum.split(numbers, 1)

    if current == 0 do
      can_be_evaluated_to_pt2?(target, rest, head)
    else
      can_be_evaluated_to_pt2?(target, rest, current + head) or
        can_be_evaluated_to_pt2?(target, rest, current * head) or
        can_be_evaluated_to_pt2?(
          target,
          rest,
          current * 10 ** (Integer.digits(head) |> length()) + head
        )
    end
  end

  @spec solve_part_2(input_part_2()) :: output_part_2()
  def solve_part_2(input) do
    input
    |> Enum.reduce(0, fn {target, numbers}, acc ->
      if can_be_evaluated_to_pt2?(target, numbers, 0) do
        acc + target
      else
        acc
      end
    end)
  end
end
