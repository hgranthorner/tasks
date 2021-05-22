defmodule TaskServerTest do
  use ExUnit.Case, async: true
  alias Tasks.Task.Server
  alias Tasks.Task

  setup do
    pid = start_supervised!(Server)
  
    [pid: pid]
  end

  test "starts", %{pid: pid} do
    assert Process.alive?(pid)
  end

  test "can add and retrieve tasks", %{pid: pid} do
    :ok = Server.add(pid, Task.new("test"))
    tasks = Server.get_tasks(pid)
    assert length(tasks) == 1
    :ok = Server.add(pid, "test 2")
    tasks = Server.get_tasks(pid)
    assert length(tasks) == 2
  end
end