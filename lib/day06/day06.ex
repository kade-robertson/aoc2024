import Combine.Parsers.Base
import Combine.Parsers.Text

defmodule AOC2024.Day06 do
  def input(), do: AOC2024.Input.read("lib/day06/input.txt")

  def name(), do: "Day 6: Guard Gallivant"

  @type input_part_1 ::
          {MapSet.t({integer(), integer()}), {integer(), integer()}, {integer(), integer()}}
  @type input_part_2 :: any()
  @type output_part_1 :: integer()
  @type output_part_2 :: integer()

  @spec parse_part_1(String.t()) :: input_part_1 | {:error, any()}
  def parse_part_1(input) do
    map =
      input
      |> Combine.parse(sep_by1(many(choice([char("."), char("#"), char("^")])), newline()))
      |> hd

    map
    |> Enum.with_index()
    |> Enum.reduce({MapSet.new(), nil, {0, 0}}, fn {row, y},
                                                   {obstructions, guard_position, {width, height}} ->
      {row_set, guard_pos} =
        row
        |> Enum.with_index()
        |> Enum.reduce({MapSet.new(), nil}, fn {cell, x}, {col, guard_position} ->
          case cell do
            "." -> {col, guard_position}
            "#" -> {MapSet.put(col, {x, y}), guard_position}
            "^" -> {col, {x, y}}
          end
        end)

      {MapSet.union(obstructions, row_set),
       if(is_nil(guard_position), do: guard_pos, else: guard_position),
       {max(width, length(row)), max(height, y + 1)}}
    end)
  end

  def rotate_direction({dx, dy}) do
    case {dx, dy} do
      {0, 1} -> {-1, 0}
      {1, 0} -> {0, 1}
      {0, -1} -> {1, 0}
      {-1, 0} -> {0, -1}
    end
  end

  def move_guard(_, {x, y}, _, {w, h}, visited) when x >= w or y >= h, do: visited
  def move_guard(_, {x, y}, _, _, visited) when x < 0 or y < 0, do: visited

  def move_guard(obstructions, {x, y}, {dx, dy}, size, visited) do
    new_position = {x + dx, y + dy}

    if MapSet.member?(obstructions, new_position) do
      move_guard(obstructions, {x, y}, rotate_direction({dx, dy}), size, visited)
    else
      move_guard(obstructions, new_position, {dx, dy}, size, MapSet.put(visited, new_position))
    end
  end

  @spec solve_part_1(input_part_1()) :: output_part_1()
  def solve_part_1(input) do
    {obstructions, guard_position, size} = input

    visited =
      move_guard(obstructions, guard_position, {0, -1}, size, MapSet.new([guard_position]))

    MapSet.size(visited) - 1
  end

  @spec parse_part_2(String.t()) :: input_part_2 | {:error, any()}
  def parse_part_2(input) do
    input |> parse_part_1()
  end

  def move_guard_pt2(_, {x, y}, _, {w, h}, _) when x >= w or y >= h, do: 0
  def move_guard_pt2(_, {x, y}, _, _, _) when x < 0 or y < 0, do: 0

  def move_guard_pt2(obstructions, {x, y}, {dx, dy}, size, visited) do
    new_position = {x + dx, y + dy}

    if MapSet.member?(obstructions, new_position) do
      move_guard_pt2(obstructions, {x, y}, rotate_direction({dx, dy}), size, visited)
    else
      if MapSet.member?(visited, {new_position, {dx, dy}}) do
        1
      else
        move_guard_pt2(
          obstructions,
          new_position,
          {dx, dy},
          size,
          MapSet.put(visited, {new_position, {dx, dy}})
        )
      end
    end
  end

  @spec solve_part_2(input_part_2()) :: output_part_2()
  def solve_part_2(input) do
    # brute force -- for each position in the grid, pretend a new obstacle is
    # there, add it to the obstacle set, and do the same math as part 1, but
    # stop on a loop when a visited set contains the same direction as well.
    {obstructions, guard_position, size} = input

    visited =
      move_guard(obstructions, guard_position, {0, -1}, size, MapSet.new([guard_position]))
      |> MapSet.delete(guard_position)

    visited
    |> Enum.reduce(0, fn {x, y}, acc ->
      new_obstructions = MapSet.put(obstructions, {x, y})

      acc +
        move_guard_pt2(
          new_obstructions,
          guard_position,
          {0, -1},
          size,
          MapSet.new([{guard_position, {0, -1}}])
        )
    end)
  end
end
