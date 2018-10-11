defmodule CSMT.MixProject do
  use Mix.Project

  def project do
    [
      app: :csmt,
      version: "0.1.0",
      elixir: "~> 1.6",
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
      {:exprotobuf, "~> 1.2"},
      {:ex_doc, "~> 0.18.0", only: :dev, runtime: false},
      {:elixir_uuid, "~> 1.2"}
    ]
  end
end
