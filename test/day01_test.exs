defmodule AOC2024Test.Day01 do
  use ExUnit.Case
  alias AOC2024.Day01
  require AOC2024.Day01

  test "parse_part_1" do
    assert Day01.parse_part_1("""
           3   4
           4   3
           2   5
           1   3
           3   9
           3   3
           """) == [{3, 4}, {4, 3}, {2, 5}, {1, 3}, {3, 9}, {3, 3}]
  end

  test "solve_part_1" do
    assert Day01.solve_part_1([{3, 4}, {4, 3}, {2, 5}, {1, 3}, {3, 9}, {3, 3}]) == 11
  end

  test "solve_part_1 with my input" do
    input =
      Day01.input()
      |> Day01.parse_part_1()
      |> Day01.solve_part_1()

    assert input == 2_086_478
  end

  test "parse_part_2" do
    assert Day01.parse_part_2("""
           3   4
           4   3
           2   5
           1   3
           3   9
           3   3
           """) == [{3, 4}, {4, 3}, {2, 5}, {1, 3}, {3, 9}, {3, 3}]
  end

  test "solve_part_2" do
    assert Day01.solve_part_2([{3, 4}, {4, 3}, {2, 5}, {1, 3}, {3, 9}, {3, 3}]) == 31
  end

  test "solve_part_2 with my input" do
    input =
      Day01.input()
      |> Day01.parse_part_2()
      |> Day01.solve_part_2()

    assert input == 24_941_624
  end
end
