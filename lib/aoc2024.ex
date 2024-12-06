defmodule AOC2024 do
  use Application

  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: AOC2024.TaskSupervisor}
    ]

    supervisor = Supervisor.start_link(children, strategy: :one_for_one)
    task = Task.Supervisor.async(AOC2024.TaskSupervisor, &AOC2024.Runner.run_problems/0)
    Task.await(task, 600_000)
    supervisor
  end
end
