defmodule Mix.Tasks.Foreperson.Start do
  use Mix.Task

  @shortdoc "Starts all configured Foreperson processes."

  @moduledoc """
  #{@shortdoc}

    $ mix foreperson.start
  """

  @impl true
  @doc false
  def run(_) do
    :ok = Application.start(:foreperson)
    Process.sleep(:infinity)
  end
end
