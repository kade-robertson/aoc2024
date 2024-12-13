defmodule AOC2024Test.Day13 do
  use ExUnit.Case
  alias AOC2024.Day13
  require AOC2024.Day13

  @example "Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176

Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=7870, Y=6450

Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=18641, Y=10279"

  test "parse_part_1" do
    assert Day13.parse_part_1(@example) == [
             %ClawMachine{ax: 94, ay: 34, bx: 22, by: 67, px: 8400, py: 5400},
             %ClawMachine{ax: 26, ay: 66, bx: 67, by: 21, px: 12748, py: 12176},
             %ClawMachine{ax: 17, ay: 86, bx: 84, by: 37, px: 7870, py: 6450},
             %ClawMachine{ax: 69, ay: 23, bx: 27, by: 71, px: 18641, py: 10279}
           ]
  end

  test "solve_part_1" do
    assert Day13.solve_part_1(Day13.parse_part_1(@example)) == 480
  end

  test "solve_part_1 with my input" do
    input =
      Day13.input()
      |> Day13.parse_part_1()
      |> Day13.solve_part_1()

    assert input == 34787
  end

  test "parse_part_2" do
    assert Day13.parse_part_2(@example) == [
             %ClawMachine{
               ax: 94,
               ay: 34,
               bx: 22,
               by: 67,
               px: 10_000_000_008_400,
               py: 10_000_000_005_400
             },
             %ClawMachine{
               ax: 26,
               ay: 66,
               bx: 67,
               by: 21,
               px: 10_000_000_012_748,
               py: 10_000_000_012_176
             },
             %ClawMachine{
               ax: 17,
               ay: 86,
               bx: 84,
               by: 37,
               px: 10_000_000_007_870,
               py: 10_000_000_006_450
             },
             %ClawMachine{
               ax: 69,
               ay: 23,
               bx: 27,
               by: 71,
               px: 10_000_000_018_641,
               py: 10_000_000_010_279
             }
           ]
  end

  test "solve_part_2" do
    assert Day13.solve_part_2(Day13.parse_part_2(@example)) == 875_318_608_908
  end

  test "solve_part_2 with my input" do
    input =
      Day13.input()
      |> Day13.parse_part_2()
      |> Day13.solve_part_2()

    assert input == 85_644_161_121_698
  end
end
