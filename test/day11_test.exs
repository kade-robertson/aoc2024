defmodule AOC2024Test.Day11 do
  use ExUnit.Case
  use Memoize
  alias AOC2024.Day11
  require AOC2024.Day11

  test "parse_part_1" do
    assert Day11.parse_part_1("0 1 10 99 999") == [0, 1, 10, 99, 999]
  end

  test "solve_part_1" do
    assert Day11.solve_part_1([125, 17]) == 55312
  end

  test "solve_part_1 with my input" do
    input =
      Day11.input()
      |> Day11.parse_part_1()
      |> Day11.solve_part_1()

    assert input == 190_865
  end

  test "parse_part_2" do
    assert Day11.parse_part_2("0 1 10 99 999") == [0, 1, 10, 99, 999]
  end

  test "solve_part_2" do
    assert Day11.solve_part_2([125, 17]) == 65_601_038_650_482
  end

  test "solve_part_2 with my input" do
    input =
      Day11.input()
      |> Day11.parse_part_2()
      |> Day11.solve_part_2()

    assert input == 225_404_711_855_335
  end
end
