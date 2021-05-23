defmodule TaskCacheTest do
  use ExUnit.Case, async: true
  alias Tasks.Task

  setup do
    pid = start_supervised!(Task.Cache)
    unassigned_pid = Task.Cache.get(pid, "unassigned")
    Task.List.add(unassigned_pid, "a task")

    [pid: pid]
  end

  test "starts", %{pid: pid} do
    assert Process.alive?(pid)
  end

  test "starts with unassigned list", %{pid: pid} do
    unassigned_pid = Task.Cache.get(pid, "unassigned")
    tasks = Task.List.get_tasks(unassigned_pid)
    assert length(tasks) == 1
  end

  test "creates new lists as needed", %{pid: pid} do
    matt_pid = Task.Cache.get(pid, "Matt")
    Task.List.add(matt_pid, "a thing")
    tasks = Task.List.get_tasks(matt_pid)
    assert length(tasks) == 1
  end
end
