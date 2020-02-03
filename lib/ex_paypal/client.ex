defmodule ExPaypal.Client do
  @moduledoc """
  Behaviours for HTTP clients.
  """

  @type r ::
          {:ok, %{status_code: integer(), headers: keyword()}}
          | {:ok, %{status_code: integer(), headers: keyword(), body: any()}}
          | {:error, %{reason: any()}}

  @doc """
  Request the given `Operation` using the runtime configurations from `Configuration`.
  """
  @callback request(
              method :: atom(),
              url :: binary(),
              headers :: keyword(),
              body :: any(),
              opts :: any()
            ) :: r()
end
