defmodule AOC2024Test.Day03 do
  use ExUnit.Case
  alias AOC2024.Day03
  require AOC2024.Day03

  test "parsePt1" do
    assert Day03.parsePt1(
             "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
           ) == [
             {2, 4},
             {5, 5},
             {11, 8},
             {8, 5}
           ]
  end

  test "solvePt1" do
    assert Day03.solvePt1([
             {2, 4},
             {5, 5},
             {11, 8},
             {8, 5}
           ]) == 161
  end

  test "solvePt1 with my input" do
    input =
      Day03.input()
      |> Day03.parsePt1()
      |> Day03.solvePt1()

    assert input == 168_539_636
  end

  test "parsePt2" do
    assert Day03.parsePt2("""
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

  test "solvePt2" do
    assert Day03.solvePt2([
             {2, 4},
             false,
             {5, 5},
             {11, 8},
             true,
             {8, 5}
           ]) == 48
  end

  test "solvePt2 with my input" do
    input =
      Day03.input()
      |> Day03.parsePt2()
      |> Day03.solvePt2()

    assert input == 97_529_391
  end
end
