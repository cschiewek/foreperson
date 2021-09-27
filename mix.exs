defmodule Foreperson.MixProject do
  use Mix.Project

  @version "0.1.4"
  @source_url "https://github.com/cschiewek/foreperson"

  def project do
    [
      app: :foreperson,
      name: "foreperson",
      version: @version,
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      description: "Process runner for external dependencies in local dev environments",
      source_url: @source_url,
      deps: deps(),
      package: package(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Foreperson.Application, []},
      start_phases: [wait: []]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Curtis Schiewek"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url},
      files: ~w(lib priv LICENSE.md mix.exs README.md .formatter.exs)
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"],
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end
end
