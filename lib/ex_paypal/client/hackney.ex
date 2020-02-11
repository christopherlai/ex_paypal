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

  def request_token(method, url, headers, body) do
    case :hackney.request(method, url, headers, body, [:with_body, follow_redirect: true]) do
      {:ok, _status, _headers} ->
        {:ok, "{}"}

      {:ok, _status, _headers, body} ->
        {:ok, body}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
