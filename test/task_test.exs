defmodule TaskTest do
  use ExUnit.Case, async: true
  alias Tasks.Task
  doctest Task

  @today Date.utc_today()

  test "creates a new task" do
    assert %Task{name: "a", description: "", assigned_to: "Unassigned", created_at: @today} =
             Task.new("a")
  end

  test "new tasks have the correct date" do
    task = Task.new("a")
    assert task.created_at == Date.utc_today()
  end

  test "can dynamically set fields" do
    task = Task.new("a", description: "some description", assigned_to: "me")
    assert %Task{description: "some description", assigned_to: "me"} = task
  end

  test "can not set private fields" do
    task = Task.new("a", id: "my id")
    assert task.id != "my id"
  end
end
