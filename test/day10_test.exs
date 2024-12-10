defmodule AOC2024Test.Day10 do
  use ExUnit.Case
  alias AOC2024.Day10
  require AOC2024.Day10

  test "parse_part_1" do
    result = Day10.parse_part_1("89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732")

    assert result |> elem(0) == %{
             0 =>
               MapSet.new([{0, 6}, {1, 7}, {2, 0}, {2, 5}, {4, 0}, {4, 2}, {5, 5}, {6, 4}, {6, 6}]),
             1 =>
               MapSet.new([{0, 7}, {1, 6}, {2, 1}, {3, 0}, {3, 5}, {4, 1}, {5, 0}, {6, 5}, {7, 6}]),
             2 => MapSet.new([{1, 5}, {3, 1}, {3, 6}, {6, 0}, {7, 5}, {7, 7}]),
             3 => MapSet.new([{0, 5}, {2, 6}, {3, 2}, {6, 7}, {7, 0}, {7, 4}]),
             4 => MapSet.new([{0, 4}, {2, 2}, {2, 7}, {3, 3}, {7, 1}, {7, 3}]),
             5 => MapSet.new([{1, 4}, {2, 3}, {3, 7}, {7, 2}]),
             6 => MapSet.new([{1, 3}, {2, 4}, {4, 7}, {6, 2}]),
             7 => MapSet.new([{0, 1}, {1, 2}, {3, 4}, {5, 7}, {6, 1}, {6, 3}]),
             8 => MapSet.new([{0, 0}, {0, 2}, {1, 1}, {4, 4}, {5, 1}, {5, 3}, {5, 6}]),
             9 => MapSet.new([{0, 3}, {1, 0}, {4, 3}, {4, 5}, {4, 6}, {5, 2}, {5, 4}])
           }
  end

  test "solve_part_1" do
    assert Day10.solve_part_1(Day10.parse_part_1("89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732")) == 36
  end

  test "solve_part_1 with my input" do
    input =
      Day10.input()
      |> Day10.parse_part_1()
      |> Day10.solve_part_1()

    assert input == 825
  end

  test "parse_part_2" do
    result = Day10.parse_part_2("89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732")

    assert result |> elem(0) == %{
             0 =>
               MapSet.new([{0, 6}, {1, 7}, {2, 0}, {2, 5}, {4, 0}, {4, 2}, {5, 5}, {6, 4}, {6, 6}]),
             1 =>
               MapSet.new([{0, 7}, {1, 6}, {2, 1}, {3, 0}, {3, 5}, {4, 1}, {5, 0}, {6, 5}, {7, 6}]),
             2 => MapSet.new([{1, 5}, {3, 1}, {3, 6}, {6, 0}, {7, 5}, {7, 7}]),
             3 => MapSet.new([{0, 5}, {2, 6}, {3, 2}, {6, 7}, {7, 0}, {7, 4}]),
             4 => MapSet.new([{0, 4}, {2, 2}, {2, 7}, {3, 3}, {7, 1}, {7, 3}]),
             5 => MapSet.new([{1, 4}, {2, 3}, {3, 7}, {7, 2}]),
             6 => MapSet.new([{1, 3}, {2, 4}, {4, 7}, {6, 2}]),
             7 => MapSet.new([{0, 1}, {1, 2}, {3, 4}, {5, 7}, {6, 1}, {6, 3}]),
             8 => MapSet.new([{0, 0}, {0, 2}, {1, 1}, {4, 4}, {5, 1}, {5, 3}, {5, 6}]),
             9 => MapSet.new([{0, 3}, {1, 0}, {4, 3}, {4, 5}, {4, 6}, {5, 2}, {5, 4}])
           }
  end

  test "solve_part_2" do
    assert Day10.solve_part_2(Day10.parse_part_2("89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732")) == 81
  end

  test "solve_part_2 with my input" do
    input =
      Day10.input()
      |> Day10.parse_part_2()
      |> Day10.solve_part_2()

    assert input == 1805
  end
end
