import Combine.Parsers.Base
import Combine.Parsers.Text

defmodule AOC2024.Day08 do
  def input(), do: AOC2024.Input.read("lib/day08/input.txt")

  def name(), do: "Day 8: Resonant Collinearity"

  @type input_part_1 :: {%{String.t() => [{integer(), integer()}]}, integer(), integer()}
  @type input_part_2 :: [{integer(), [integer()]}]
  @type output_part_1 :: integer()
  @type output_part_2 :: integer()

  @spec parse_part_1(String.t()) :: input_part_1 | {:error, any()}
  def parse_part_1(input) do
    input
    |> Combine.parse(sep_by1(many(either(alphanumeric(), char("."))), newline()))
    |> hd
    |> Enum.with_index()
    |> Enum.reduce({%{}, 0, 0}, fn {row, y}, {antennas, w, _} ->
      {row
       |> Enum.with_index()
       |> Enum.reduce(antennas, fn {cell, x}, acc ->
         case cell do
           "." -> acc
           _ -> Map.update(acc, cell, [{x, y}], &([{x, y}] ++ &1))
         end
       end), max(w, length(row)), y + 1}
    end)
  end

  def is_in_bounds?({x, y}, {width, height}) do
    x >= 0 and x < width and y >= 0 and y < height
  end

  def compute_antinodes({x1, y1}, {x2, y2}, bounds) do
    dx = x2 - x1
    dy = y2 - y1

    [{x1 - dx, y1 - dy}, {x2 + dx, y2 + dy}]
    |> Enum.filter(fn pt -> is_in_bounds?(pt, bounds) end)
  end

  def combinations(positions) do
    for x <- positions, y <- positions, x != y, do: {x, y}
  end

  @spec solve_part_1(input_part_1()) :: output_part_1()
  def solve_part_1(input) do
    {antennas, width, height} = input

    antennas
    |> Enum.flat_map(fn {_, positions} -> positions |> Enum.sort() |> combinations() end)
    |> Enum.reduce(MapSet.new(), fn {a, b}, acc ->
      compute_antinodes(a, b, {width, height})
      |> Enum.reduce(acc, fn pt, acc -> MapSet.put(acc, pt) end)
    end)
    |> MapSet.size()
  end

  @spec parse_part_2(String.t()) :: input_part_2 | {:error, any()}
  def parse_part_2(input) do
    input |> parse_part_1()
  end

  def bwd_antinode(_, _, {0, 0}), do: []
  def bwd_antinode({x, y}, _, {w, h}) when x < 0 or y < 0 or x >= w or y >= h, do: []

  def bwd_antinode({x, y}, {dx, dy}, bounds) do
    [{x, y}] ++ bwd_antinode({x - dx, y - dy}, {dx, dy}, bounds)
  end

  def fwd_antinode(_, _, {0, 0}), do: []
  def fwd_antinode({x, y}, _, {w, h}) when x < 0 or y < 0 or x >= w or y >= h, do: []

  def fwd_antinode({x, y}, {dx, dy}, bounds) do
    [{x, y}] ++ fwd_antinode({x + dx, y + dy}, {dx, dy}, bounds)
  end

  def compute_antinodes_pt2({x1, y1}, {x2, y2}, bounds) do
    dx = x2 - x1
    dy = y2 - y1

    bwd_antinode({x1 - dx, y1 - dy}, {dx, dy}, bounds) ++
      fwd_antinode({x2 - dx, y2 - dy}, {dx, dy}, bounds)
  end

  def draw(antennas, antinodes, {width, height}) do
    for y <- 0..(height - 1) do
      for x <- 0..(width - 1) do
        antenna =
          Enum.find_value(antennas, fn {chr, positions} ->
            Enum.find_value(positions, fn {x1, y1} -> if x1 == x and y1 == y, do: chr end)
          end)

        if antenna do
          IO.write(antenna)
        else
          antinode = Enum.find_value(antinodes, fn {x1, y1} -> x1 == x and y1 == y end)

          if antinode do
            IO.write("#")
          else
            IO.write(".")
          end
        end
      end

      IO.puts("")
    end
  end

  @spec solve_part_2(input_part_2()) :: output_part_2()
  def solve_part_2(input) do
    {antennas, width, height} = input

    antennas
    |> Enum.flat_map(fn {_, positions} -> positions |> Enum.sort() |> combinations() end)
    |> Enum.reduce(MapSet.new(), fn {a, b}, acc ->
      compute_antinodes_pt2(a, b, {width, height})
      |> Enum.reduce(acc, fn pt, acc -> MapSet.put(acc, pt) end)
    end)
    |> MapSet.size()
  end
end
