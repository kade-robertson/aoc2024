import Combine.Parsers.Base
import Combine.Parsers.Text

defmodule AOC2024.Day12 do
  def input(), do: AOC2024.Input.read("lib/day12/input.txt")

  def name(), do: "Day 12: Garden Groups"

  @type input_part_1 :: list(list(String.t()))
  @type input_part_2 :: input_part_1
  @type output_part_1 :: integer()
  @type output_part_2 :: integer()

  @spec parse_part_1(String.t()) :: input_part_1
  def parse_part_1(input) do
    input |> Combine.parse(sep_by1(many(alphanumeric()), newline())) |> hd
  end

  def pos_group_map(positions) do
    Enum.with_index(positions)
    |> Enum.reduce(%{}, fn {group, y}, acc ->
      Enum.with_index(group)
      |> Enum.reduce(acc, fn {cell, x}, acc -> Map.put(acc, {x, y}, cell) end)
    end)
  end

  def find_groups(points_map) do
    points = Map.keys(points_map)
    find_groups(points_map, points, MapSet.new(), [])
  end

  def find_groups(_, [], _, groups), do: groups

  def find_groups(points_map, [point | rest], visited, groups) do
    if MapSet.member?(visited, point) do
      find_groups(points_map, rest, visited, groups)
    else
      {new_visited, group} = flood_fill(points_map, [point], MapSet.new([point]), MapSet.new())
      find_groups(points_map, rest, MapSet.union(visited, new_visited), [group | groups])
    end
  end

  def get_neighbors({x, y}) do
    [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]
  end

  def flood_fill(_, [], visited, group), do: {visited, group}

  def flood_fill(points_map, [point | rest], visited, group) do
    value = Map.get(points_map, point)

    neighbors =
      get_neighbors(point)
      |> Enum.filter(fn p ->
        Map.get(points_map, p) == value && !MapSet.member?(visited, p)
      end)

    new_visited = Enum.reduce(neighbors, visited, fn p, acc -> MapSet.put(acc, p) end)
    flood_fill(points_map, neighbors ++ rest, new_visited, MapSet.put(group, point))
  end

  @spec solve_part_1(input_part_1()) :: output_part_1()
  def solve_part_1(input) do
    rows = Enum.count(input) - 1
    cols = Enum.count(hd(input)) - 1

    pos_to_group = pos_group_map(input)

    neighbors_in_group =
      Enum.reduce(0..rows, %{}, fn y, acc ->
        Enum.reduce(0..cols, acc, fn x, acc ->
          group = Map.get(pos_to_group, {x, y})

          if group == nil do
            acc
          else
            acc
            |> Map.put(
              {x, y},
              [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]
              |> Enum.reduce(0, fn {nx, ny}, acc ->
                if nx < 0 or nx > cols or ny < 0 or ny > rows do
                  acc
                else
                  case Map.get(pos_to_group, {nx, ny}) do
                    ^group -> acc + 1
                    _ -> acc
                  end
                end
              end)
            )
          end
        end)
      end)

    find_groups(pos_to_group)
    |> Enum.reduce(0, fn group, acc ->
      area = Enum.count(group)

      perimeter =
        Enum.reduce(group, 0, fn {x, y}, acc ->
          acc + (4 - Map.get(neighbors_in_group, {x, y}, 0))
        end)

      acc + area * perimeter
    end)
  end

  @spec parse_part_2(String.t()) :: input_part_2
  def parse_part_2(input) do
    input |> parse_part_1()
  end

  def check(pos_to_group, pos, adj1, adj2, corner) do
    pos = Map.get(pos_to_group, pos)
    adj1 = Map.get(pos_to_group, adj1)
    adj2 = Map.get(pos_to_group, adj2)
    corner = Map.get(pos_to_group, corner)

    if (pos != adj1 and pos != adj2) || (pos == adj1 and pos == adj2 and pos != corner),
      do: 1,
      else: 0
  end

  def count_corners(group, pos_to_group) do
    Enum.reduce(group, 0, fn {x, y}, acc ->
      acc + check(pos_to_group, {x, y}, {x, y - 1}, {x + 1, y}, {x + 1, y - 1}) +
        check(pos_to_group, {x, y}, {x + 1, y}, {x, y + 1}, {x + 1, y + 1}) +
        check(pos_to_group, {x, y}, {x, y + 1}, {x - 1, y}, {x - 1, y + 1}) +
        check(pos_to_group, {x, y}, {x - 1, y}, {x, y - 1}, {x - 1, y - 1})
    end)
  end

  @spec solve_part_2(input_part_2()) :: output_part_2()
  def solve_part_2(input) do
    pos_to_group = pos_group_map(input)

    find_groups(pos_to_group)
    |> Enum.map(fn group ->
      Enum.count(group) * count_corners(group, pos_to_group)
    end)
    |> Enum.sum()
  end
end
