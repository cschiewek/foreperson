defmodule Foreperson do
  @moduledoc """
  # Configuration

  Foreperson has 2 configuration options:

  `wait:`

  The amount of time to pause before finalizing startup.  This is useful if the configured process isn't instantly ready.
  For example, if your elixir app uses `ecto` and you want to use `foreperson` to start a `postgres` instance, you can set a
  wait time to ensure postgres is ready before `ecto` tries to connect.

  `processes:`

  A list of exertnal processes that you want to start.  The syntax is the similar to [Phoenix endpoint watchers](https://hexdocs.pm/phoenix/Phoenix.Endpoint.html#module-runtime-configuration).
  The key is the commmand to run, followed by a list of strings representing command args,
  followed by a keyword list of options.

  The available options are:
  - `:wrap`: Use a [zombie process wrapper](https://hexdocs.pm/elixir/master/Port.html#module-zombie-operating-system-processes). Defaults to `true`.
  - `:into`: Injects the result into the given collectable. Defaults to `IO.stream(:stdio, :line)`.
  - `:stderr_to_stdout` - redirects stderr to stdout.  Defaults to `true`.
  - All the options available to [System.cmd/3](https://hexdocs.pm/elixir/System.html#cmd/3-options)

  ### Example
  ```
  config :foreperson,
    wait: 500, # Wait 500ms
    processes: [
      postgres: [], # Run postgres with no command args
      "redis-server": ["--loglevel", "warning", wrap: false] # Run redis, and don't use the wrapper script.
    ]
  ```
  """
end
