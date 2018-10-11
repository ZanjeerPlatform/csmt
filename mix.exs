defmodule CSMT.MixProject do
  use Mix.Project

  def project do
    [
      app: :csmt,
      version: "1.0.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp description do
    "Compact Sparse Merkle Trees (CSMT) with pluggable storage."
  end

  defp package do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "csmt",
      # These are the default files included in the package
      files: ~w(lib .formatter.exs mix.exs README.md LICENSE),
      maintainers: ["Faraz Haider"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/ZanjeerPlatform/csmt"
      }
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:exprotobuf, :logger]
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
