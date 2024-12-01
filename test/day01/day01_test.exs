defmodule AOC2024Test.Day01 do
  use ExUnit.Case
  alias AOC2024.Day01
  require AOC2024.Day01

  test "parsePt1" do
    assert Day01.parsePt1("""
           3   4
           4   3
           2   5
           1   3
           3   9
           3   3
           """) == [{3, 4}, {4, 3}, {2, 5}, {1, 3}, {3, 9}, {3, 3}]
  end

  test "solvePt1" do
    assert Day01.solvePt1([{3, 4}, {4, 3}, {2, 5}, {1, 3}, {3, 9}, {3, 3}]) == 11
  end

  test "solvePt1 with my input" do
    input =
      Day01.input()
      |> Day01.parsePt1()
      |> Day01.solvePt1()

    assert input == 2_086_478
  end

  test "parsePt2" do
    assert Day01.parsePt2("""
           3   4
           4   3
           2   5
           1   3
           3   9
           3   3
           """) == [{3, 4}, {4, 3}, {2, 5}, {1, 3}, {3, 9}, {3, 3}]
  end

  test "solvePt2" do
    assert Day01.solvePt2([{3, 4}, {4, 3}, {2, 5}, {1, 3}, {3, 9}, {3, 3}]) == 31
  end

  test "solvePt2 with my input" do
    input =
      Day01.input()
      |> Day01.parsePt2()
      |> Day01.solvePt2()

    assert input == 24_941_624
  end
end
