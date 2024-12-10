import Combine.Parsers.Base
import Combine.Parsers.Text

defmodule AOC2024.Day05 do
  def input(), do: AOC2024.Input.read("lib/day05/input.txt")

  def name(), do: "Day 5: Print Queue"

  @type input_part_1 :: {list({integer(), integer()}), list(list(integer()))}
  @type input_part_2 :: {list({integer(), integer()}), list(list(integer()))}
  @type output_part_1 :: integer()
  @type output_part_2 :: integer()

  @spec parse_part_1(String.t()) :: input_part_1
  def parse_part_1(input) do
    parsed =
      input
      |> Combine.parse(
        sep_by1(pipe([integer(), ignore(char("|")), integer()], &Function.identity/1), newline())
        |> ignore(newline())
        |> ignore(newline())
        |> sep_by1(sep_by1(integer(), char(",")), newline())
      )

    {
      parsed |> hd |> Enum.map(&List.to_tuple/1),
      parsed |> tl |> hd
    }
  end

  @spec make_banlist(list({integer(), integer()})) :: %{integer() => list(integer())}
  def make_banlist(rules) do
    rules
    |> Enum.reduce(%{}, fn {a, b}, acc ->
      Map.update(acc, b, MapSet.new([a]), fn set -> MapSet.put(set, a) end)
    end)
  end

  @spec scan_update(list(integer()), %{integer() => list(integer())}) :: boolean()
  def scan_update(row, banlist) do
    row
    |> Enum.reduce({true, MapSet.new()}, fn x, {state, banned} ->
      if not state, do: {false, banned}

      if MapSet.member?(banned, x) do
        {false, banned}
      else
        {state, MapSet.union(banned, Map.get(banlist, x, MapSet.new()))}
      end
    end)
    |> elem(0)
  end

  @spec solve_part_1(input_part_1()) :: output_part_1()
  def solve_part_1(input) do
    banlist = input |> elem(0) |> make_banlist()

    input
    |> elem(1)
    |> Enum.filter(fn row -> scan_update(row, banlist) end)
    |> Enum.map(fn row -> Enum.at(row, (Enum.count(row) / 2) |> trunc()) end)
    |> Enum.sum()
  end

  @spec parse_part_2(String.t()) :: input_part_2
  def parse_part_2(input) do
    input |> parse_part_1()
  end

  @spec row_ordering_inner(
          %{integer() => MapSet.t(integer())},
          %{integer() => integer()},
          list(integer()),
          list(integer())
        ) :: list(integer())
  def row_ordering_inner(_, _, [], out), do: out

  def row_ordering_inner(fwd, row_ordering, queue, out) do
    {first, rest} = queue |> Enum.split(1) |> then(fn {a, b} -> {a |> hd, b} end)

    {new_row_ordering, new_queue} =
      Map.get(fwd, first, MapSet.new())
      |> Enum.to_list()
      |> Enum.reduce({row_ordering, rest}, fn x, {ro, q} ->
        priority = Map.get(ro, x, -1)

        if priority == -1 do
          {ro, q}
        else
          new_priority = priority - 1

          Map.put(ro, x, new_priority)
          |> then(fn new_ro ->
            if new_priority == 0 do
              {new_ro, [x | q]}
            else
              {new_ro, q}
            end
          end)
        end
      end)

    row_ordering_inner(fwd, new_row_ordering, new_queue, [first | out])
  end

  @spec reorder_row(list(integer()), %{integer() => MapSet.t(integer())}) :: list(integer())
  def reorder_row(row, ordering) do
    seen = row |> MapSet.new()
    {fwd, bwd} = ordering

    row_ordering =
      Enum.reduce(row, %{}, fn x, acc ->
        Map.put(
          acc,
          x,
          Map.get(bwd, x, MapSet.new()) |> MapSet.intersection(seen) |> MapSet.size()
        )
      end)

    queue =
      Enum.filter(row, fn x -> Map.get(row_ordering, x, 0) == 0 end)

    row_ordering_inner(fwd, row_ordering, queue, [])
  end

  @spec solve_part_2(input_part_2()) :: output_part_2()
  def solve_part_2(input) do
    banlist = input |> elem(0) |> make_banlist()
    bad_rows = input |> elem(1) |> Enum.filter(fn row -> not scan_update(row, banlist) end)

    ordering =
      input
      |> elem(0)
      |> Enum.reduce({%{}, %{}}, fn {a, b}, {fwd, bwd} ->
        {
          Map.update(fwd, a, MapSet.new([b]), fn set -> MapSet.put(set, b) end),
          Map.update(bwd, b, MapSet.new([a]), fn set -> MapSet.put(set, a) end)
        }
      end)

    bad_rows
    |> Enum.map(fn row -> reorder_row(row, ordering) end)
    |> Enum.map(fn row -> Enum.at(row, (Enum.count(row) / 2) |> trunc()) end)
    |> Enum.sum()
  end
end
