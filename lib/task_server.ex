defmodule Tasks.Task.Server do
  use GenServer
  alias Tasks.Task

  @spec start_link(list(Task.t())) :: pid()
  def start_link(default) when is_list(default) do
    GenServer.start_link(__MODULE__, default)
  end

  @spec add(pid(), Task.t()) :: atom()
  def add(pid, task) do
    GenServer.call(pid, {:add, task})
  end

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