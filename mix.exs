defmodule Newton.MixProject do
  use Mix.Project

  def project do
    [
      app: :newton,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.12"},
      {:plug_socket, "~> 0.1.0"},
      {:plug_cowboy, "~> 2.5"},

      # consider making optional
      {:jason, "~> 1.0"}
    ]
  end
end
