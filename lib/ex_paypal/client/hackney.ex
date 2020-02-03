defmodule ExPaypal.Client.Hackney do
  @behaviour ExPaypal.Client

  def request(method, url, headers, body, opts \\ []) do
    case :hackney.request(method, url, headers, body, [:with_body] ++ opts) do
      {:ok, status, headers} ->
        {:ok, %{status_code: status, headers: headers}}

      {:ok, status, headers, body} ->
        {:ok, %{status_code: status, headers: headers, body: body}}

      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end
end
