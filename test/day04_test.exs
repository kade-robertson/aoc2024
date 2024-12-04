defmodule AOC2024Test.Day04 do
  use ExUnit.Case
  alias AOC2024.Day04
  require AOC2024.Day04

  test "parsePt1" do
    assert Day04.parsePt1("MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX") == [
             ["M", "M", "M", "S", "X", "X", "M", "A", "S", "M"],
             ["M", "S", "A", "M", "X", "M", "S", "M", "S", "A"],
             ["A", "M", "X", "S", "X", "M", "A", "A", "M", "M"],
             ["M", "S", "A", "M", "A", "S", "M", "S", "M", "X"],
             ["X", "M", "A", "S", "A", "M", "X", "A", "M", "M"],
             ["X", "X", "A", "M", "M", "X", "X", "A", "M", "A"],
             ["S", "M", "S", "M", "S", "A", "S", "X", "S", "S"],
             ["S", "A", "X", "A", "M", "A", "S", "A", "A", "A"],
             ["M", "A", "M", "M", "M", "X", "M", "M", "M", "M"],
             ["M", "X", "M", "X", "A", "X", "M", "A", "S", "X"]
           ]
  end

  test "solvePt1" do
    assert Day04.solvePt1([
             ["M", "M", "M", "S", "X", "X", "M", "A", "S", "M"],
             ["M", "S", "A", "M", "X", "M", "S", "M", "S", "A"],
             ["A", "M", "X", "S", "X", "M", "A", "A", "M", "M"],
             ["M", "S", "A", "M", "A", "S", "M", "S", "M", "X"],
             ["X", "M", "A", "S", "A", "M", "X", "A", "M", "M"],
             ["X", "X", "A", "M", "M", "X", "X", "A", "M", "A"],
             ["S", "M", "S", "M", "S", "A", "S", "X", "S", "S"],
             ["S", "A", "X", "A", "M", "A", "S", "A", "A", "A"],
             ["M", "A", "M", "M", "M", "X", "M", "M", "M", "M"],
             ["M", "X", "M", "X", "A", "X", "M", "A", "S", "X"]
           ]) == 18
  end

  test "solvePt1 with my input" do
    input =
      Day04.input()
      |> Day04.parsePt1()
      |> Day04.solvePt1()

    assert input == 2642
  end

  test "parsePt2" do
    assert Day04.parsePt2("MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX") == [
             ["M", "M", "M", "S", "X", "X", "M", "A", "S", "M"],
             ["M", "S", "A", "M", "X", "M", "S", "M", "S", "A"],
             ["A", "M", "X", "S", "X", "M", "A", "A", "M", "M"],
             ["M", "S", "A", "M", "A", "S", "M", "S", "M", "X"],
             ["X", "M", "A", "S", "A", "M", "X", "A", "M", "M"],
             ["X", "X", "A", "M", "M", "X", "X", "A", "M", "A"],
             ["S", "M", "S", "M", "S", "A", "S", "X", "S", "S"],
             ["S", "A", "X", "A", "M", "A", "S", "A", "A", "A"],
             ["M", "A", "M", "M", "M", "X", "M", "M", "M", "M"],
             ["M", "X", "M", "X", "A", "X", "M", "A", "S", "X"]
           ]
  end

  test "solvePt2" do
    assert Day04.solvePt2([
             ["M", "M", "M", "S", "X", "X", "M", "A", "S", "M"],
             ["M", "S", "A", "M", "X", "M", "S", "M", "S", "A"],
             ["A", "M", "X", "S", "X", "M", "A", "A", "M", "M"],
             ["M", "S", "A", "M", "A", "S", "M", "S", "M", "X"],
             ["X", "M", "A", "S", "A", "M", "X", "A", "M", "M"],
             ["X", "X", "A", "M", "M", "X", "X", "A", "M", "A"],
             ["S", "M", "S", "M", "S", "A", "S", "X", "S", "S"],
             ["S", "A", "X", "A", "M", "A", "S", "A", "A", "A"],
             ["M", "A", "M", "M", "M", "X", "M", "M", "M", "M"],
             ["M", "X", "M", "X", "A", "X", "M", "A", "S", "X"]
           ]) == 9
  end

  test "solvePt2 with my input" do
    input =
      Day04.input()
      |> Day04.parsePt2()
      |> Day04.solvePt2()

    assert input == 1974
  end
end