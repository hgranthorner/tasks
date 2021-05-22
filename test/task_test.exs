defmodule TaskTest do
	use ExUnit.Case
	alias Tasks.Task
	doctest Task

	test "creates a new task" do
		assert Task.new("a") == %Task{name: "a", description: "", assigned_to: "Unassigned", created_at: Date.utc_today()}
	end

	test "new tasks have the correct date" do
		task = Task.new("a")
		assert task.created_at == Date.utc_today()
	end

	test "can dynamically set fields" do
		task = Task.new("a", description: "some description", assigned_to: "me")
		assert %Task{description: "some description", assigned_to: "me"} = task
	end
end