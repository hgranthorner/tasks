defmodule Tasks.Task do
	defstruct [:name, :description, :created_at]

	@type t :: %__MODULE__ {
		name: String.t(),
		description: String.t(),
		created_at: Date.t()
	}

	@spec new(String.t(), String.t()) :: t()
	def new(name, description) do
		%__MODULE__{name: name, description: description, created_at: Date.utc_today()}
	end
end