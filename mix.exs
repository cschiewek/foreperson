defmodule Foreperson.MixProject do
  use Mix.Project

  def project do
    [
      app: :foreperson,
      name: "foreperson",
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      description: "Process runner for external dependencies in local dev environments",
      deps: deps(),
      package: package()
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
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Curtis Schiewek"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/phoenixframework/phoenix"},
      files: ~w(lib priv LICENSE.md mix.exs README.md .formatter.exs)
    ]
  end
end
