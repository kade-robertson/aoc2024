defmodule AOC2024.Day04 do
  def input(), do: AOC2024.Input.read("lib/day04/input.txt")

  def name(), do: "Day 4: Mull It Over"

  @type inputPt1 :: list(list(char()))
  @type inputPt2 :: list(list(char()))
  @type outputPt1 :: integer()
  @type outputPt2 :: integer()

  @spec parsePt1(String.t()) :: inputPt1 | {:error, any()}
  def parsePt1(input) do
    input |> String.split("\n") |> Enum.map(&String.graphemes/1)
  end

  def is_xmas([a, b, c, d]) do
    (a == "X" and b == "M" and c == "A" and d == "S") or
      (a == "S" and b == "A" and c == "M" and d == "X")
  end

  def is_xmas(_), do: false

  def scan_rows(input) do
    Enum.map(input, fn row ->
      Enum.reduce(0..(Enum.count(row) - 4), 0, fn i, acc ->
        if Enum.slice(row, i, 4) |> is_xmas() do
          acc + 1
        else
          acc
        end
      end)
    end)
    |> Enum.sum()
  end

  def transpose(input) do
    Enum.zip(input) |> Enum.map(&Tuple.to_list/1)
  end

  def scan_columns(input) do
    transpose(input) |> scan_rows()
  end

  def rotate_left(row, amount) do
    {front, back} = row |> Enum.split(amount)
    back ++ front
  end

  def rotate_right(row, amount) do
    rotate_left(row, -amount)
  end

  def pad_row(row) do
    [".", ".", ".", "."] ++ row ++ [".", ".", ".", "."]
  end

  def scan_fwd_diagonals(input) do
    input
    |> Enum.map(&pad_row/1)
    |> Enum.with_index()
    |> Enum.map(fn {row, i} -> rotate_left(row, i) end)
    |> scan_columns()
  end

  def scan_bwd_diagonals(input) do
    input
    |> Enum.map(&pad_row/1)
    |> Enum.with_index()
    |> Enum.map(fn {row, i} -> rotate_right(row, i) end)
    |> scan_columns()
  end

  @spec solvePt1(inputPt1()) :: outputPt1()
  def solvePt1(input) do
    scan_rows(input) + scan_columns(input) + scan_fwd_diagonals(input) + scan_bwd_diagonals(input)
  end

  @spec parsePt2(String.t()) :: inputPt2 | {:error, any()}
  def parsePt2(input) do
    input |> parsePt1()
  end

  def is_xcrossmas([["M", _, "S"], [_, "A", _], ["M", _, "S"]]), do: true
  def is_xcrossmas([["S", _, "M"], [_, "A", _], ["S", _, "M"]]), do: true
  def is_xcrossmas([["M", _, "M"], [_, "A", _], ["S", _, "S"]]), do: true
  def is_xcrossmas([["S", _, "S"], [_, "A", _], ["M", _, "M"]]), do: true
  def is_xcrossmas(_), do: false

  def scan_xcross(input) do
    Enum.reduce(0..(Enum.count(input) - 3), 0, fn i, acc ->
      row_chunk = Enum.slice(input, i, 3) |> transpose()

      acc +
        Enum.reduce(0..(Enum.count(row_chunk) - 3), 0, fn j, acc ->
          if Enum.slice(row_chunk, j, 3) |> is_xcrossmas() do
            acc + 1
          else
            acc
          end
        end)
    end)
  end

  @spec solvePt2(inputPt2()) :: outputPt2()
  def solvePt2(input) do
    input |> scan_xcross()
  end
end
