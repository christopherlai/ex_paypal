defmodule ExPaypal.Credential.Cache do
  use GenServer
  alias ExPaypal.Token

  @name __MODULE__

  def start_link(_opts) do
    GenServer.start_link(@name, :ok, name: @name)
  end

  def init(:ok) do
    ets = :ets.new(@name, [:set, :protected, :named_table, read_concurrency: true])
    {:ok, ets}
  end

  def get(configuration) do
    case :ets.lookup(@name, :credential) do
      [{:credential, results}] -> results
      [] -> GenServer.call(@name, {:refresh_credential, configuration})
    end
  end

  def handle_call({:refresh_credential, configuration}, _form, ets) do
    credential = refresh_credential(configuration)

    {:reply, credential, ets}
  end

  def handle_info({:refresh_credential, configuration}, ets) do
    refresh_credential(configuration)

    {:noreply, ets}
  end

  defp refresh_credential(configuration) do
    credential =
      configuration
      |> Token.request()
      |> schedule_refresh(configuration)

    :ets.insert(@name, {:credential, credential})

    credential
  end

  defp schedule_refresh(credential, configuration) do
    expires_in = :timer.seconds(credential.expires_in)
    buffer = :timer.minutes(5)
    Process.send_after(self(), {:refresh_credential, configuration}, expires_in - buffer)

    credential
  end
end
