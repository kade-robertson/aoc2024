defmodule AOC2024Test.Day02 do
  use ExUnit.Case
  alias AOC2024.Day02
  require AOC2024.Day02

  test "parse_part_1" do
    assert Day02.parse_part_1("""
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

  test "solve_part_1" do
    assert Day02.solve_part_1([
             [7, 6, 4, 2, 1],
             [1, 2, 7, 8, 9],
             [9, 7, 6, 2, 1],
             [1, 3, 2, 4, 5],
             [8, 6, 4, 4, 1],
             [1, 3, 6, 7, 9]
           ]) == 2
  end

  test "solve_part_1 with my input" do
    input =
      Day02.input()
      |> Day02.parse_part_1()
      |> Day02.solve_part_1()

    assert input == 246
  end

  test "parse_part_2" do
    assert Day02.parse_part_2("""
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

  test "solve_part_2" do
    assert Day02.solve_part_2([
             [7, 6, 4, 2, 1],
             [1, 2, 7, 8, 9],
             [9, 7, 6, 2, 1],
             [1, 3, 2, 4, 5],
             [8, 6, 4, 4, 1],
             [1, 3, 6, 7, 9]
           ]) == 4
  end

  test "solve_part_2 with my input" do
    input =
      Day02.input()
      |> Day02.parse_part_2()
      |> Day02.solve_part_2()

    assert input == 318
  end
end
