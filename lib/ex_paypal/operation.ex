defmodule ExPaypal.Operation do
  @type t :: %__MODULE__{
          http_method: atom(),
          headers: keyword(),
          path: binary(),
          body: any()
        }

  defstruct http_method: :get,
            headers: [{"Content-Type", "application/json"}, {"Accept", "application/json"}],
            path: "/",
            body: ""

  @doc """
  new  `Operation` struct with the given arguments.
  """
  @spec new(method :: atom(), path :: binary(), body :: any()) :: t()
  def new(method, path, body \\ "") do
    struct(__MODULE__, http_method: method, path: path, body: body)
  end
end
