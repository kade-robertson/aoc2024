defmodule AOC2024.Day09 do
  def input(), do: AOC2024.Input.read("lib/day09/input.txt")

  def name(), do: "Day 9: Disk Fragmenter"

  @type input_part_1 :: list(integer())
  @type input_part_2 :: list(integer())
  @type output_part_1 :: integer()
  @type output_part_2 :: integer()

  @spec parse_part_1(String.t()) :: input_part_1 | {:error, any()}
  def parse_part_1(input) do
    input
    |> String.trim()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.flat_map(fn {n, i} ->
      List.duplicate(if(rem(i, 2) == 0, do: round(i / 2), else: -1), n)
    end)
  end

  def prune_last(blocks) do
    blocks
    |> Enum.reverse()
    |> Enum.drop(1)
    |> Enum.drop_while(fn x -> x == -1 end)
    |> Enum.reverse()
  end

  def defrag([], _, out), do: out

  def defrag(blocks, reverse, out) do
    {block, rest} = Enum.split(blocks, 1)
    block = hd(block)

    if block == -1 do
      {new_block, new_reverse} = Enum.split(reverse, 1)
      defrag(prune_last(rest), new_reverse, new_block ++ out)
    else
      defrag(rest, reverse, [block] ++ out)
    end
  end

  @spec solve_part_1(input_part_1()) :: output_part_1()
  def solve_part_1(input) do
    rev = Enum.reverse(input) |> Enum.filter(fn x -> x != -1 end)

    defrag(input, rev, [])
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {x, i}, acc -> acc + x * i end)
  end

  @spec parse_part_2(String.t()) :: input_part_2 | {:error, any()}
  def parse_part_2(input) do
    input |> parse_part_1()
  end

  @spec pop_match(integer(), list(list(integer()))) :: {list(integer()), list(list(integer()))}
  def pop_match(0, files), do: {nil, files}
  def pop_match(_, []), do: {nil, []}

  def pop_match(size, files) do
    case Enum.find(files, fn f -> length(f) <= size end) do
      nil -> pop_match(size - 1, files)
      file -> {file, Enum.filter(files, fn f -> f != file end)}
    end
  end

  def pop_match_while_space(0, files), do: {[], files}
  def pop_match_while_space(_, []), do: {[], []}

  def pop_match_while_space(size, files) do
    case pop_match(size, files) do
      {nil, _} ->
        pop_match_while_space(size - 1, files)

      {file, new_files} ->
        {next_file, next_files} = pop_match_while_space(size - length(file), new_files)

        case next_file do
          nil -> {[file], next_files}
          _ -> {[file | next_file], next_files}
        end
    end
  end

  def defrag_pt2([], _, out), do: out

  def defrag_pt2(blocks, reverse, out) do
    {block, rest} = Enum.split(blocks, 1)
    block = hd(block)
    block_num = hd(block)

    case block_num do
      -1 ->
        {new_blocks, new_reverse} =
          pop_match_while_space(length(block), reverse)

        goal_size = length(block)
        new_block_size = Enum.map(new_blocks, &Enum.count/1) |> Enum.sum()

        new_blocks =
          if new_block_size < goal_size,
            do: new_blocks ++ [List.duplicate(-1, goal_size - new_block_size)],
            else: new_blocks

        defrag_pt2(
          rest
          |> Enum.map(fn x ->
            if Enum.member?(new_blocks, x), do: List.duplicate(-1, length(x)), else: x
          end),
          new_reverse,
          Enum.reverse(new_blocks) ++ out
        )

      _ ->
        defrag_pt2(
          rest,
          Enum.filter(reverse, fn x -> x != block end),
          [block] ++ out
        )
    end
  end

  @spec solve_part_2(input_part_2()) :: output_part_2()
  def solve_part_2(input) do
    {rest, last} =
      input
      |> Enum.reduce({[], []}, fn x, {acc, current} ->
        cmp = if length(current) > 0, do: hd(current), else: -1

        case x do
          ^cmp -> {acc, [x | current]}
          _ -> {[current | acc], [x]}
        end
      end)

    grouped_blocks = [last | rest] |> Enum.filter(fn x -> length(x) > 0 end)

    files_by_size =
      grouped_blocks |> Enum.filter(fn x -> hd(x) != -1 end)

    defrag_pt2(grouped_blocks |> Enum.reverse(), files_by_size, [])
    |> Enum.reverse()
    |> Enum.flat_map(&Function.identity/1)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {x, i}, acc -> if x != -1, do: acc + x * i, else: acc end)
  end
end
