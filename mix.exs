defmodule Foreperson.MixProject do
  use Mix.Project

  def project do
    [
      app: :foreperson,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: true,
      deps: deps()
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
end
