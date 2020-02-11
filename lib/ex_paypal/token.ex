defmodule ExPaypal.Token do
  require Logger
  alias ExPaypal.Credential

  @path "/v1/oauth2/token"

  def request(configuration) do
    url = configuration.api_url <> @path
    body = {:form, [grant_type: "client_credentials"]}
    encoded_keys = Base.encode64("#{configuration.client_id}:#{configuration.client_secret}")
    headers = [{"Accept", "application/json"}, {"Authorization", "Basic #{encoded_keys}"}]

    case configuration.http_client.request_token(:post, url, headers, body) do
      {:ok, body} ->
        body
        |> configuration.json_library.decode!()
        |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
        |> Credential.new()

      {:error, reason} ->
        Logger.error("Unable to obtain access token, reason: #{inspect(reason)}")
        Credential.new([])
    end
  end
end
