defmodule AOC2024Test.Day06 do
  use ExUnit.Case
  alias AOC2024.Day06
  require AOC2024.Day06

  test "parse_part_1" do
    assert Day06.parse_part_1("....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...") ==
             {MapSet.new([{0, 8}, {1, 6}, {2, 3}, {4, 0}, {6, 9}, {7, 4}, {8, 7}, {9, 1}]),
              {4, 6}, {10, 10}}
  end

  test "solve_part_1" do
    assert Day06.solve_part_1(
             {MapSet.new([{0, 8}, {1, 6}, {2, 3}, {4, 0}, {6, 9}, {7, 4}, {8, 7}, {9, 1}]),
              {4, 6}, {10, 10}}
           ) == 41
  end

  @tag :skip
  test "solve_part_1 with my input" do
    input =
      Day06.input()
      |> Day06.parse_part_1()
      |> Day06.solve_part_1()

    assert input == 4752
  end

  test "parse_part_2" do
    assert Day06.parse_part_2("....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...") ==
             {MapSet.new([{0, 8}, {1, 6}, {2, 3}, {4, 0}, {6, 9}, {7, 4}, {8, 7}, {9, 1}]),
              {4, 6}, {10, 10}}
  end

  test "solve_part_2" do
    assert Day06.solve_part_2(
             {MapSet.new([{0, 8}, {1, 6}, {2, 3}, {4, 0}, {6, 9}, {7, 4}, {8, 7}, {9, 1}]),
              {4, 6}, {10, 10}}
           ) == 6
  end

  test "solve_part_2 with my input" do
    input =
      Day06.input()
      |> Day06.parse_part_2()
      |> Day06.solve_part_2()

    assert input == 1719
  end
end
