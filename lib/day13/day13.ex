import Combine.Parsers.Base
import Combine.Parsers.Text

defmodule ClawMachine do
  use Memoize
  defstruct ax: 0, ay: 0, bx: 0, by: 0, px: 0, py: 0

  @type t :: %__MODULE__{
          ax: integer(),
          ay: integer(),
          bx: integer(),
          by: integer(),
          px: integer(),
          py: integer()
        }

  def close_to_integer?(value) do
    abs(value - trunc(value)) < 0.0000001
  end

  @spec min_cost(ClawMachine.t()) :: integer()
  def min_cost(machine) do
    # (ax * i) + (bx * j) = px
    # (ay * i) + (by * j) = py
    # ---
    # ax * i = px - (bx * j)
    # i = (px - (bx * j)) / ax
    # -
    # ay * ((px - (bx * j)) / ax) + (by * j) = py
    # ay * (px / ax) - ay * (bx / ax) * j + (by * j) = py
    # ay * (px / ax) + (by - (ay * bx) / ax) * j = py
    # (by - (ay * bx) / ax) * j = py - (ay * (px / ax))
    # j = (py - (ay * (px / ax))) / (by - (ay * bx) / ax)
    # j = (ax * (py - (ay * (px / ax)))) / (ax * (by - (ay * bx) / ax))
    # j = (ax * py - ay * px) / (ax * by - ay * bx)

    j_1 = machine.ax * machine.py - machine.ay * machine.px
    j_2 = machine.ax * machine.by - machine.ay * machine.bx

    case rem(j_1, j_2) do
      0 ->
        j = (j_1 / j_2) |> trunc()
        i_1 = machine.px - machine.bx * j
        i = (i_1 / machine.ax) |> trunc()

        case rem(i_1, machine.ax) do
          0 -> 3 * i + j
          _ -> :inf
        end

      _ ->
        :inf
    end
  end

  # leaving in my original brute force solution for reference
  def min_cost_v1(machine), do: min_cost_v1(machine, 100)

  def min_cost_v1(machine, max_steps) do
    a_cap =
      min(
        max_steps,
        max((machine.px / machine.ax + 1) |> trunc(), (machine.py / machine.ay + 1) |> trunc())
      )

    b_cap =
      min(
        max_steps,
        max((machine.px / machine.bx + 1) |> trunc(), (machine.py / machine.by + 1) |> trunc())
      )

    solve_bf(machine, 0, 0, 0, 0, a_cap, b_cap)
  end

  defmemo(
    solve_bf(_, _, _, a_moves, b_moves, a_cap, b_cap) when a_moves > a_cap or b_moves > b_cap,
    do: :inf
  )

  defmemo(solve_bf(machine, x, y, _, _, _, _) when x == machine.px and y == machine.py, do: 0)
  defmemo(solve_bf(machine, x, y, _, _, _, _) when x > machine.px or y > machine.py, do: :inf)

  defmemo solve_bf(machine, x, y, a_moves, b_moves, a_cap, b_cap) do
    a_cost = solve_bf(machine, x + machine.ax, y + machine.ay, a_moves + 1, b_moves, a_cap, b_cap)
    a_cost = if a_cost == :inf, do: :inf, else: a_cost + 3
    b_cost = solve_bf(machine, x + machine.bx, y + machine.by, a_moves, b_moves + 1, a_cap, b_cap)
    b_cost = if b_cost == :inf, do: :inf, else: b_cost + 1

    min(a_cost, b_cost)
  end
end

defmodule AOC2024.Day13 do
  def input(), do: AOC2024.Input.read("lib/day13/input.txt")

  def name(), do: "Day 13: Claw Contraption"

  @type input_part_1 :: any()
  @type input_part_2 :: input_part_1
  @type output_part_1 :: integer()
  @type output_part_2 :: integer()

  def parse_button(chr) do
    ignore(string("Button "))
    |> ignore(char(chr))
    |> ignore(string(": X+"))
    |> integer()
    |> ignore(string(", Y+"))
    |> integer()
  end

  def parse_prize() do
    ignore(string("Prize: X="))
    |> integer()
    |> ignore(string(", Y="))
    |> integer()
  end

  @spec parse_part_1(String.t()) :: input_part_1
  def parse_part_1(input) do
    input
    |> Combine.parse(
      sep_by1(
        pipe(
          [
            parse_button("A"),
            ignore(newline()),
            parse_button("B"),
            ignore(newline()),
            parse_prize()
          ],
          &Function.identity/1
        ),
        many1(newline())
      )
    )
    |> hd
    |> Enum.map(fn [ax, ay, bx, by, px, py] ->
      %ClawMachine{ax: ax, ay: ay, bx: bx, by: by, px: px, py: py}
    end)
  end

  @spec solve_part_1(input_part_1()) :: output_part_1()
  def solve_part_1(input) do
    input |> Enum.map(&ClawMachine.min_cost/1) |> Enum.filter(fn v -> v != :inf end) |> Enum.sum()
  end

  @spec parse_part_2(String.t()) :: input_part_2
  def parse_part_2(input) do
    input
    |> parse_part_1()
    |> Enum.map(fn c ->
      %ClawMachine{c | px: 10_000_000_000_000 + c.px, py: 10_000_000_000_000 + c.py}
    end)
  end

  @spec solve_part_2(input_part_2()) :: output_part_2()
  def solve_part_2(input) do
    input |> solve_part_1()
  end
end
