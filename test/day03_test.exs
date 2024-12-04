defmodule AOC2024Test.Day03 do
  use ExUnit.Case
  alias AOC2024.Day03
  require AOC2024.Day03

  test "parse_part_1" do
    assert Day03.parse_part_1(
             "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
           ) == [
             {2, 4},
             {5, 5},
             {11, 8},
             {8, 5}
           ]
  end

  test "solve_part_1" do
    assert Day03.solve_part_1([
             {2, 4},
             {5, 5},
             {11, 8},
             {8, 5}
           ]) == 161
  end

  test "solve_part_1 with my input" do
    input =
      Day03.input()
      |> Day03.parse_part_1()
      |> Day03.solve_part_1()

    assert input == 168_539_636
  end

  test "parse_part_2" do
    assert Day03.parse_part_2("""
             "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
           """) ==
             [
               {2, 4},
               false,
               {5, 5},
               {11, 8},
               true,
               {8, 5}
             ]
  end

  test "solve_part_2" do
    assert Day03.solve_part_2([
             {2, 4},
             false,
             {5, 5},
             {11, 8},
             true,
             {8, 5}
           ]) == 48
  end

  test "solve_part_2 with my input" do
    input =
      Day03.input()
      |> Day03.parse_part_2()
      |> Day03.solve_part_2()

    assert input == 97_529_391
  end
end
