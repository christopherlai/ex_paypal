defmodule ExPaypal do
  require Logger
  alias ExPaypal.Configuration
  alias ExPaypal.Credential.Cache

  def request(operation) do
    configuration = Configuration.new()
    credential = Cache.get(configuration)
    method = operation.http_method
    url = build_url(operation, configuration)
    headers = build_headers(operation, credential)
    body = build_body(operation, configuration)

    case configuration.http_client.request(method, url, headers, body, []) do
      {:ok, %{status_code: status, headers: _headers, body: body}} when status in 200..299 ->
        {:ok, configuration.json_library.decode!(body)}

      {:ok, %{status_code: status, headers: _headers}} when status in 200..299 ->
        {:ok, %{}}

      {:ok, %{status_code: status, headers: _headers}} when status == 301 ->
        Logger.error("Request was redirected")
        {:error, "redirected"}

      {:ok, %{body: body}} ->
        Logger.error("Unable to complete request. Reason: #{inspect(body)}")
        {:error, configuration.json_library.decode!(body)}

      {:error, %{reason: reason}} ->
        Logger.error("Unable to complete request. Reason: #{inspect(reason)}")
        {:error, reason}
    end
  end

  def build_url(operation, configuration) do
    configuration.api_url <> operation.path
  end

  def build_headers(operation, credential) do
    List.keystore(
      operation.headers,
      "Authorization",
      0,
      {"Authorization", "#{credential.token_type} #{credential.access_token}"}
    )
  end

  def build_body(%{body: body}, configuration) when is_map(body) do
    configuration.json_library.encode!(body)
  end

  def build_body(%{body: body}), do: body
end
