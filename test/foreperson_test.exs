defmodule ForepersonTest do
  use ExUnit.Case
  doctest Foreperson

  @tag capture_log: true
  test "starts processes from config" do
    assert %{active: 0, specs: 0, supervisors: 0, workers: 0} =
             Supervisor.count_children(Foreperson.Supervisor)

    :ok = Application.stop(:foreperson)
    Application.put_env(:foreperson, :processes, sh: ["echo"])
    :ok = Application.start(:foreperson)

    assert %{active: 1, specs: 1, supervisors: 0, workers: 1} =
             Supervisor.count_children(Foreperson.Supervisor)
  end
end
