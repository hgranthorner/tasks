defmodule Tasks.Task.Server do
  use GenServer
  alias Tasks.Task

  @doc """
  Create the server.
  """
  @spec start_link(list(Task.t())) :: pid()
  def start_link(default) when is_list(default) do
    IO.puts("Creating task server.")
    GenServer.start_link(__MODULE__, default)
  end

  @doc """
  Add a task by name. The task is created internally.
  """
  @spec add(pid(), String.t()) :: atom()
  def add(pid, name) when is_binary(name) do
    GenServer.call(pid, {:add, Task.new(name)})
  end

  @doc """
  Add a task struct.
  """
  @spec add(pid(), Task.t()) :: atom()
  def add(pid, %Task{} = task) do
    GenServer.call(pid, {:add, task})
  end

  @doc """
  Get all tasks.
  """
  @spec get_tasks(pid()) :: list(Task.t())
  def get_tasks(pid) do
    GenServer.call(pid, :get)
  end

  @impl true
  def init(opts \\ []) do
    {:ok, opts}
  end

  @impl true
  def handle_call(:get, _from, tasks) do
    {:reply, tasks, tasks}
  end

  @impl true
  def handle_call({:add, task}, _from, tasks) do
    {:reply, :ok, [task | tasks]}
  end
end