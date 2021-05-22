defmodule Tasks.Task do
	defstruct [:name, id: UUID.uuid4(), description: "", created_at: Date.utc_today(), assigned_to: "Unassigned"]

	@type keys :: [description: String.t(), created_at: Date.t(), assigned_to: String.t()]

	@type t :: %__MODULE__{
		name: String.t(),
		description: String.t(),
		assigned_to: String.t(),
		created_at: Date.t()
	}

	@doc """
	Creates a new task.

	Returns the task.

	## Examples

		iex> Tasks.Task.new("a name", assigned_to: "you")
		%Task{name: "a name", description: "", created_at: Date.utc_today(), assigned_to: "you"}
	
	"""
	@spec new(String.t(), keys) :: t()
	def new(name, opts \\ []) do
		%__MODULE__{name: name}
		|> try_add(opts, :description)
		|> try_add(opts, :assigned_to)
		|> try_add(opts, :created_at)
	end


	@spec try_add(t(), keys, atom()) :: t()
	defp try_add(%__MODULE__{} = task, opts, key) do
		if Keyword.has_key?(opts, key) do
			%{task | key => Keyword.get(opts, key)}
		else
	 		task
		end
	end
end