defmodule Tasks.Task.Cache do
  use GenServer
  alias Tasks.Task

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{})
  end

  @spec get(pid(), String.t()) :: pid()
  def get(pid, name) when is_binary(name) do
    GenServer.call(pid, {:get, name})
  end

  @impl true
  def init(map) do
    {:ok, pid} = Task.List.start_link("Unassigned")
    map = Map.put(map, "unassigned", pid)
    {:ok, map}
  end

  @impl true
  def handle_call({:get, name}, _from, map) do
    normalized_name = String.downcase(name)
    pid = Map.get(map, normalized_name)

    if pid do
      {:reply, pid, map}
    else
      {:ok, pid} = Task.List.start_link(name)
      map = Map.put(map, normalized_name, pid)
      {:reply, pid, map}
    end
  end
end
