defmodule ExPayl.ConfigurationTest do
  use ExUnit.Case
  alias ExPaypal.Configuration

  setup do
    configs = [
      client_id: "id",
      client_secret: "secert",
      api_url: "https://api.sandbox.paypal.com"
    ]

    put_envs(configs)

    {:ok, %{configs: configs}}
  end

  describe "new/1" do
    test "returns a `Configuration` struct", %{configs: configs} do
      configuration = Configuration.new()
      assert configuration.client_id == configs[:client_id]
      assert configuration.client_secret == configs[:client_secret]
      assert configuration.api_url == configs[:api_url]
      assert configuration.http_opts == []
      assert configuration.json_library == Jason
    end

    test "returns a `Configuration` struct with the given opts", %{configs: configs} do
      put_env(:client_id, "new_id")
      configuration = Configuration.new()
      assert configuration.client_id == "new_id"
      assert configuration.client_secret == configs[:client_secret]
    end

    test "raise if `client_id` is missing" do
      assert_raise RuntimeError, fn ->
        delete_env(:client_id)
        Configuration.new()
      end
    end

    test "raise if `client_secret` is missing" do
      assert_raise RuntimeError, fn ->
        delete_env(:client_secret)
        Configuration.new()
      end
    end

    test "raise if `api_url` is missing" do
      assert_raise RuntimeError, fn ->
        delete_env(:api_url)
        Configuration.new()
      end
    end
  end

  defp put_env(key, value) do
    Application.put_env(:ex_paypal, key, value)
  end

  defp delete_env(key) do
    Application.delete_env(:ex_paypal, key)
  end

  defp put_envs(configs) do
    Application.put_all_env(ex_paypal: configs)
  end
end
