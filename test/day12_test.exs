defmodule AOC2024Test.Day12 do
  use ExUnit.Case
  alias AOC2024.Day12
  require AOC2024.Day12

  test "parse_part_1" do
    assert Day12.parse_part_1("RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE") == [
             ["R", "R", "R", "R", "I", "I", "C", "C", "F", "F"],
             ["R", "R", "R", "R", "I", "I", "C", "C", "C", "F"],
             ["V", "V", "R", "R", "R", "C", "C", "F", "F", "F"],
             ["V", "V", "R", "C", "C", "C", "J", "F", "F", "F"],
             ["V", "V", "V", "V", "C", "J", "J", "C", "F", "E"],
             ["V", "V", "I", "V", "C", "C", "J", "J", "E", "E"],
             ["V", "V", "I", "I", "I", "C", "J", "J", "E", "E"],
             ["M", "I", "I", "I", "I", "I", "J", "J", "E", "E"],
             ["M", "I", "I", "I", "S", "I", "J", "E", "E", "E"],
             ["M", "M", "M", "I", "S", "S", "J", "E", "E", "E"]
           ]
  end

  test "solve_part_1" do
    assert Day12.solve_part_1([
             ["R", "R", "R", "R", "I", "I", "C", "C", "F", "F"],
             ["R", "R", "R", "R", "I", "I", "C", "C", "C", "F"],
             ["V", "V", "R", "R", "R", "C", "C", "F", "F", "F"],
             ["V", "V", "R", "C", "C", "C", "J", "F", "F", "F"],
             ["V", "V", "V", "V", "C", "J", "J", "C", "F", "E"],
             ["V", "V", "I", "V", "C", "C", "J", "J", "E", "E"],
             ["V", "V", "I", "I", "I", "C", "J", "J", "E", "E"],
             ["M", "I", "I", "I", "I", "I", "J", "J", "E", "E"],
             ["M", "I", "I", "I", "S", "I", "J", "E", "E", "E"],
             ["M", "M", "M", "I", "S", "S", "J", "E", "E", "E"]
           ]) == 1930
  end

  test "solve_part_1 with my input" do
    input =
      Day12.input()
      |> Day12.parse_part_1()
      |> Day12.solve_part_1()

    assert input == 1_396_562
  end

  test "parse_part_2" do
    assert Day12.parse_part_2("RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE") == [
             ["R", "R", "R", "R", "I", "I", "C", "C", "F", "F"],
             ["R", "R", "R", "R", "I", "I", "C", "C", "C", "F"],
             ["V", "V", "R", "R", "R", "C", "C", "F", "F", "F"],
             ["V", "V", "R", "C", "C", "C", "J", "F", "F", "F"],
             ["V", "V", "V", "V", "C", "J", "J", "C", "F", "E"],
             ["V", "V", "I", "V", "C", "C", "J", "J", "E", "E"],
             ["V", "V", "I", "I", "I", "C", "J", "J", "E", "E"],
             ["M", "I", "I", "I", "I", "I", "J", "J", "E", "E"],
             ["M", "I", "I", "I", "S", "I", "J", "E", "E", "E"],
             ["M", "M", "M", "I", "S", "S", "J", "E", "E", "E"]
           ]
  end

  test "solve_part_2" do
    assert Day12.solve_part_2([
             ["R", "R", "R", "R", "I", "I", "C", "C", "F", "F"],
             ["R", "R", "R", "R", "I", "I", "C", "C", "C", "F"],
             ["V", "V", "R", "R", "R", "C", "C", "F", "F", "F"],
             ["V", "V", "R", "C", "C", "C", "J", "F", "F", "F"],
             ["V", "V", "V", "V", "C", "J", "J", "C", "F", "E"],
             ["V", "V", "I", "V", "C", "C", "J", "J", "E", "E"],
             ["V", "V", "I", "I", "I", "C", "J", "J", "E", "E"],
             ["M", "I", "I", "I", "I", "I", "J", "J", "E", "E"],
             ["M", "I", "I", "I", "S", "I", "J", "E", "E", "E"],
             ["M", "M", "M", "I", "S", "S", "J", "E", "E", "E"]
           ]) == 1206
  end

  test "solve_part_2 with my input" do
    input =
      Day12.input()
      |> Day12.parse_part_2()
      |> Day12.solve_part_2()

    assert input == 844_132
  end
end
