defmodule Foreperson.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children =
      :foreperson
      |> Application.get_env(:processes, [])
      |> Enum.map(&{Foreperson.Process, &1})

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Foreperson.Supervisor]

    Supervisor.start_link(children, opts)
  end

  @impl true
  @spec start_phase(:wait, :normal, any) :: :ok
  def start_phase(:wait, :normal, _phase_args) do
    :foreperson
    |> Application.get_env(:wait, 0)
    |> Process.sleep()

    :ok
  end
end
