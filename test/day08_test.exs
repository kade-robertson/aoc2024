defmodule AOC2024Test.Day08 do
  use ExUnit.Case
  alias AOC2024.Day08
  require AOC2024.Day08

  test "parse_part_1" do
    assert Day08.parse_part_1("............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............") ===
             {%{"0" => [{4, 4}, {7, 3}, {5, 2}, {8, 1}], "A" => [{9, 9}, {8, 8}, {6, 5}]}, 12, 12}
  end

  test "solve_part_1" do
    assert Day08.solve_part_1(
             {%{"0" => [{4, 4}, {7, 3}, {5, 2}, {8, 1}], "A" => [{9, 9}, {8, 8}, {6, 5}]}, 12, 12}
           ) == 14
  end

  test "solve_part_1 with my input" do
    input =
      Day08.input()
      |> Day08.parse_part_1()
      |> Day08.solve_part_1()

    assert input == 348
  end

  test "parse_part_2" do
    assert Day08.parse_part_2("............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............") ==
             {%{"0" => [{4, 4}, {7, 3}, {5, 2}, {8, 1}], "A" => [{9, 9}, {8, 8}, {6, 5}]}, 12, 12}
  end

  test "solve_part_2" do
    assert Day08.solve_part_2(
             {%{"0" => [{4, 4}, {7, 3}, {5, 2}, {8, 1}], "A" => [{9, 9}, {8, 8}, {6, 5}]}, 12, 12}
           ) == 34
  end

  test "solve_part_2 with my input" do
    input =
      Day08.input()
      |> Day08.parse_part_2()
      |> Day08.solve_part_2()

    assert input == 1221
  end
end
