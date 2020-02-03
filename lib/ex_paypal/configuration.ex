defmodule ExPaypal.Configuration do
  @moduledoc """
  `Configuration` structs return runtime configurations.
  """

  @type t :: %__MODULE__{
          client_id: binary() | nil,
          client_secret: binary() | nil,
          api_url: binary() | nil,
          http_client: module(),
          http_opts: keyword(),
          json_library: module()
        }

  defstruct client_id: nil,
            client_secret: nil,
            api_url: nil,
            http_client: ExPaypal.Client.Hackney,
            http_opts: [],
            json_library: Jason

  @doc """
  New `Configuration` struct with defaults.
  """
  @spec new(opts :: keyword()) :: t()
  def new(opts \\ []) do
    fields =
      :ex_paypal
      |> Application.get_all_env()
      |> Keyword.merge(opts)

    unless fields[:client_id] do
      raise ":client_id is nil in :ex_paypal configuration."
    end

    unless fields[:client_secret] do
      raise ":client_secret is nil in :ex_paypal configuration."
    end

    unless fields[:api_url] do
      raise ":api_url is nil in :ex_paypal configuration."
    end

    struct(__MODULE__, fields)
  end
end
