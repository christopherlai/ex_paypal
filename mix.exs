defmodule ExPaypal.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_paypal,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExPaypal.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:hackney, "~> 1.15", optional: true},
      {:jason, "~> 1.1", optional: true}
    ]
  end
end
