defmodule Foreperson.Process do
  @moduledoc false
  # Shamelessly copied from Phoenix.Endpoint.Watcher

  require Logger

  def child_spec(args) do
    %{
      id: make_ref(),
      start: {__MODULE__, :start_link, [args]},
      restart: :transient
    }
  end

  def start_link({cmd, args}) do
    Task.start_link(__MODULE__, :run, [to_string(cmd), args])
  end

  def run(cmd, args) when is_list(args) do
    {args, opts} = Enum.split_while(args, &is_binary(&1))
    {wrap, opts} = Keyword.pop(opts, :wrap, true)
    opts = Keyword.merge([into: Foreperson.stream(cmd), stderr_to_stdout: true], opts)

    {args, cmd} =
      case wrap do
        true -> {[Path.join(:code.priv_dir(:foreperson), "wrapper.sh"), cmd] ++ args, "sh"}
        false -> {args, cmd}
      end

    try do
      System.cmd(cmd, args, opts)
    catch
      :error, :enoent ->
        relative = Path.relative_to_cwd(cmd)

        Logger.error(
          "Could not start #{inspect(relative)} from #{inspect(cd(opts))}, executable does not exist"
        )

        exit(:shutdown)
    else
      {_, 0} ->
        :ok

      {_, _} ->
        # System.cmd returned a non-zero exit code
        # sleep for a couple seconds before exiting to ensure this doesn't
        # hit the supervisor's max_restarts / max_seconds limit
        Process.sleep(2000)
        exit(:watcher_command_error)
    end
  end

  defp cd(opts), do: opts[:cd] || File.cwd!()
end
