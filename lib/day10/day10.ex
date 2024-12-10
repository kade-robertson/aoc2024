defmodule AOC2024.Day10 do
  def input(), do: AOC2024.Input.read("lib/day10/input.txt")

  def name(), do: "Day 10: Hoof It"

  @type input_part_1 ::
          {%{integer() => MapSet.t({integer(), integer()})},
           %{{integer(), integer()} => integer()}, integer(), integer()}
  @type input_part_2 ::
          {%{integer() => MapSet.t({integer(), integer()})},
           %{{integer(), integer()} => integer()}, integer(), integer()}
  @type output_part_1 :: integer()
  @type output_part_2 :: integer()

  @spec parse_part_1(String.t()) :: input_part_1
  def parse_part_1(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.graphemes(line) |> Enum.map(&String.to_integer/1) |> Enum.with_index()
    end)
    |> Enum.with_index()
    |> Enum.reduce({%{}, %{}, 0, 0}, fn {row, y}, {by_num, by_coord, w, h} ->
      Enum.reduce(row, {by_num, by_coord, w, h}, fn {num, x}, {by_num, by_coord, w, h} ->
        {Map.update(by_num, num, MapSet.new([{x, y}]), fn ms -> MapSet.put(ms, {x, y}) end),
         Map.put(by_coord, {x, y}, num), max(w, x), max(h, y)}
      end)
    end)
  end

  def neighbor({x, y}, {w, h}) when x < 0 or x > w or y < 0 or y > h, do: nil
  def neighbor({x, y}, _), do: {x, y}

  def neighbors({x, y}, {w, h}) do
    [
      {x, y - 1},
      {x + 1, y},
      {x, y + 1},
      {x - 1, y}
    ]
    |> Enum.map(fn p -> neighbor(p, {w, h}) end)
    |> Enum.filter(fn p -> p != nil end)
  end

  def traverse({by_num, by_coord, w, h}, start) do
    level = Map.get(by_coord, start)

    if level == 9 do
      MapSet.new([{start}])
    else
      possible = Map.get(by_num, level + 1)

      neighbors(start, {w, h})
      |> Enum.filter(fn p -> MapSet.member?(possible, p) end)
      |> Enum.map(fn p -> traverse({by_num, by_coord, w, h}, p) end)
      |> Enum.reduce(MapSet.new(), fn paths, acc -> MapSet.union(paths, acc) end)
    end
  end

  @spec solve_part_1(input_part_1()) :: output_part_1()
  def solve_part_1(input) do
    {by_num, by_coord, w, h} = input

    Map.get(by_num, 0)
    |> MapSet.to_list()
    |> Enum.map(fn pos -> traverse({by_num, by_coord, w, h}, pos) |> MapSet.size() end)
    |> Enum.sum()
  end

  @spec parse_part_2(String.t()) :: input_part_2 | {:error, any()}
  def parse_part_2(input) do
    input |> parse_part_1()
  end

  def traverse_pt2({by_num, by_coord, w, h}, start) do
    level = Map.get(by_coord, start)

    if level == 9 do
      1
    else
      possible = Map.get(by_num, level + 1)

      neighbors(start, {w, h})
      |> Enum.filter(fn p -> MapSet.member?(possible, p) end)
      |> Enum.map(fn p -> traverse_pt2({by_num, by_coord, w, h}, p) end)
      |> Enum.sum()
    end
  end

  @spec solve_part_2(input_part_2()) :: output_part_2()
  def solve_part_2(input) do
    {by_num, by_coord, w, h} = input

    Map.get(by_num, 0)
    |> MapSet.to_list()
    |> Enum.map(fn pos -> traverse_pt2({by_num, by_coord, w, h}, pos) end)
    |> Enum.sum()
  end
end
