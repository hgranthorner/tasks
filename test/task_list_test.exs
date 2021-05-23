defmodule TaskListTest do
  use ExUnit.Case, async: true
  alias Tasks.Task

  setup do
    pid = start_supervised!({Task.List, "name"})

    [pid: pid]
  end

  test "starts", %{pid: pid} do
    assert Process.alive?(pid)
  end

  test "can add and retrieve tasks", %{pid: pid} do
    :ok = Task.List.add(pid, Task.new("test"))
    tasks = Task.List.get_tasks(pid)
    assert length(tasks) == 1
    :ok = Task.List.add(pid, "test 2")
    tasks = Task.List.get_tasks(pid)
    assert length(tasks) == 2
  end
end
