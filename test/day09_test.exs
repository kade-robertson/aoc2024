defmodule AOC2024Test.Day09 do
  use ExUnit.Case
  alias AOC2024.Day09
  require AOC2024.Day09

  test "parse_part_1" do
    assert Day09.parse_part_1("2333133121414131402") === [
             0,
             0,
             -1,
             -1,
             -1,
             1,
             1,
             1,
             -1,
             -1,
             -1,
             2,
             -1,
             -1,
             -1,
             3,
             3,
             3,
             -1,
             4,
             4,
             -1,
             5,
             5,
             5,
             5,
             -1,
             6,
             6,
             6,
             6,
             -1,
             7,
             7,
             7,
             -1,
             8,
             8,
             8,
             8,
             9,
             9
           ]
  end

  test "solve_part_1" do
    assert Day09.solve_part_1([
             0,
             0,
             -1,
             -1,
             -1,
             1,
             1,
             1,
             -1,
             -1,
             -1,
             2,
             -1,
             -1,
             -1,
             3,
             3,
             3,
             -1,
             4,
             4,
             -1,
             5,
             5,
             5,
             5,
             -1,
             6,
             6,
             6,
             6,
             -1,
             7,
             7,
             7,
             -1,
             8,
             8,
             8,
             8,
             9,
             9
           ]) == 1928
  end

  test "solve_part_1 with my input" do
    input =
      Day09.input()
      |> Day09.parse_part_1()
      |> Day09.solve_part_1()

    assert input == 6_395_800_119_709
  end

  test "parse_part_2" do
    assert Day09.parse_part_2("2333133121414131402") == [
             0,
             0,
             -1,
             -1,
             -1,
             1,
             1,
             1,
             -1,
             -1,
             -1,
             2,
             -1,
             -1,
             -1,
             3,
             3,
             3,
             -1,
             4,
             4,
             -1,
             5,
             5,
             5,
             5,
             -1,
             6,
             6,
             6,
             6,
             -1,
             7,
             7,
             7,
             -1,
             8,
             8,
             8,
             8,
             9,
             9
           ]
  end

  test "solve_part_2" do
    assert Day09.solve_part_2([
             0,
             0,
             -1,
             -1,
             -1,
             1,
             1,
             1,
             -1,
             -1,
             -1,
             2,
             -1,
             -1,
             -1,
             3,
             3,
             3,
             -1,
             4,
             4,
             -1,
             5,
             5,
             5,
             5,
             -1,
             6,
             6,
             6,
             6,
             -1,
             7,
             7,
             7,
             -1,
             8,
             8,
             8,
             8,
             9,
             9
           ]) == 2858
  end

  test "solve_part_2 with my input" do
    input =
      Day09.input()
      |> Day09.parse_part_2()
      |> Day09.solve_part_2()

    assert input == 6_418_529_470_362
  end
end
