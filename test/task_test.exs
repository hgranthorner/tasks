defmodule TaskTest do
	use ExUnit.Case
	alias Tasks.Task
	doctest Task

	test "creates a new task" do
		assert Task.new("a", "b") == %Task{name: "a", description: "b", created_at: Date.utc_today()}
	end

	test "new tasks have the correct date" do
		task = Task.new("a", "A")
		assert task.created_at == Date.utc_today()
	end
end