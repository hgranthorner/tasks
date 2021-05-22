defmodule Tasks.Task.List do
  use GenServer
  alias Tasks.Task

  @type state :: {String.t(), list(Task.t())}
  @type call_res(t) :: {:reply, t, state}

  @doc """
  Create the server.
  """
  def start_link(name) when is_binary(name) do
    GenServer.start_link(__MODULE__, name)
  end

  @doc """
  Add a task.
  """
  @spec add(pid(), String.t()) :: atom()
  def add(pid, name) when is_binary(name) do
    GenServer.call(pid, {:add, Task.new(name)})
  end
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
  def init(name) do
    {:ok, {name, []}}
  end

  @impl true
  @spec handle_call(atom(), pid(), state) :: call_res([Task.t()])
  def handle_call(:get, _from, {_, tasks} = state) do
    {:reply, tasks, state}
  end

  @impl true
  def handle_call({:add, task}, _from, {name, tasks}) do
    {:reply, :ok, {name, [%Task{task | assigned_to: name} | tasks]}}
  end
end