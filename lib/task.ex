defmodule Tasks.Task do
  alias __MODULE__

  defstruct [
    :name,
    status: "To do",
    id: UUID.uuid4(),
    description: "",
    created_at: Date.utc_today(),
    assigned_to: "Unassigned"
  ]

  @type t :: %Task{
          name: String.t(),
          status: String.t(),
          id: UUID.t(),
          description: String.t(),
          created_at: Date.t(),
          assigned_to: String.t()
        }

  @not_modifiable [:__struct__, :id]

  @doc """
  Creates a new task.

  Returns the task.

  ## Examples

  	iex> Tasks.Task.new("a name", assigned_to: "you")
  	%Task{name: "a name", status: "To do", description: "", created_at: Date.utc_today(), assigned_to: "you"}

  """
  @spec new(String.t(), key: any()) :: t()
  def new(name, opts \\ []) do
    opts = Enum.filter(opts, fn {key, _} -> not Enum.member?(@not_modifiable, key) end)

    %Task{name: name}
    |> apply_opts(opts)
  end

  @spec apply_opts(t(), key: any()) :: t()
  defp apply_opts(%Task{} = task, [{key, value} | rest]) do
    apply_opts(%{task | key => value}, rest)
  end

  @spec apply_opts(t(), []) :: t()
  defp apply_opts(%Task{} = task, []) do
    task
  end

  defp try_add(%Task{} = task, key, value) do
    %{task | key => value}
  end
end
