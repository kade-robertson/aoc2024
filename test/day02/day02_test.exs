defmodule AOC2024Test.Day02 do
  use ExUnit.Case
  alias AOC2024.Day02
  require AOC2024.Day02

  test "parsePt1" do
    assert Day02.parsePt1("""
           7 6 4 2 1
           1 2 7 8 9
           9 7 6 2 1
           1 3 2 4 5
           8 6 4 4 1
           1 3 6 7 9
           """) == [
             [7, 6, 4, 2, 1],
             [1, 2, 7, 8, 9],
             [9, 7, 6, 2, 1],
             [1, 3, 2, 4, 5],
             [8, 6, 4, 4, 1],
             [1, 3, 6, 7, 9]
           ]
  end

  test "solvePt1" do
    assert Day02.solvePt1([
             [7, 6, 4, 2, 1],
             [1, 2, 7, 8, 9],
             [9, 7, 6, 2, 1],
             [1, 3, 2, 4, 5],
             [8, 6, 4, 4, 1],
             [1, 3, 6, 7, 9]
           ]) == 2
  end

  test "solvePt1 with my input" do
    input =
      Day02.input()
      |> Day02.parsePt1()
      |> Day02.solvePt1()

    assert input == 246
  end

  test "parsePt2" do
    assert Day02.parsePt2("""
           7 6 4 2 1
           1 2 7 8 9
           9 7 6 2 1
           1 3 2 4 5
           8 6 4 4 1
           1 3 6 7 9
           """) ==
             [
               [7, 6, 4, 2, 1],
               [1, 2, 7, 8, 9],
               [9, 7, 6, 2, 1],
               [1, 3, 2, 4, 5],
               [8, 6, 4, 4, 1],
               [1, 3, 6, 7, 9]
             ]
  end

  test "solvePt2" do
    assert Day02.solvePt2([
             [7, 6, 4, 2, 1],
             [1, 2, 7, 8, 9],
             [9, 7, 6, 2, 1],
             [1, 3, 2, 4, 5],
             [8, 6, 4, 4, 1],
             [1, 3, 6, 7, 9]
           ]) == 4
  end

  test "solvePt2 with my input" do
    input =
      Day02.input()
      |> Day02.parsePt2()
      |> Day02.solvePt2()

    assert input == 318
  end
end
