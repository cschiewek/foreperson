# Foreperson

[![Continuous Integration](https://github.com/cschiewek/foreperson/actions/workflows/ci.yml/badge.svg)](https://github.com/cschiewek/foreperson/actions/workflows/ci.yml)

Generic process runner.  Inspired by [foreman](https://github.com/ddollar/foreman) and [Phoenix endpoint watchers](https://hexdocs.pm/phoenix/Phoenix.Endpoint.html#module-runtime-configuration).

_Please don't use this in production.  It's meant for local development and testing only.  It's designed for convenience, not resiliency._

## Installation

The package can be installed by adding `foreperson` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:foreperson, "~> 0.1", only: [:dev, :test]}
  ]
end
```

## Configuration

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
- `:into`: Injects the result into the given collectable. Defaults to `Foreperson.stream(cmd)` where `cmd` is the name of the process.
- `:stderr_to_stdout` - redirects stderr to stdout.  Defaults to `true`.
- All the options available to [System.cmd/3](https://hexdocs.pm/elixir/System.html#cmd/3-options)

### Example
```elixir
config :foreperson,
  wait: 500, # Wait 500ms
  processes: [
    postgres: [], # Run postgres with no command args
    "redis-server": ["--loglevel", "warning", wrap: false] # Run redis, and don't use the wrapper script.
  ]
```

## Running in seperate process or shell

By default, Foreperson will run under your applications main supervisor.  However, can run it in it's own process in a different shell.

Set runtime to false in your `mix.exs` deps
```elixir
{:foreperson, "~> 0.1", only: [:dev, :test], runtime: false}
```

Then start it via the mix task
```shell
$ mix foreperson.start
```

## Why?

I end up needing to run multiple instances of different versions of external dependencies for my Elixir apps. asdf is great for switching versions, but there's no great story for starting and stoping those processes.

I typically end up using docker-compose, but Docker on MacOS has some frustrating issues.  I've also used foreman in the passed to varying degrees of success. I was looking for a similar solution in Elixir, but couldn't find anything, so here we are.

This is probably a terrible way to solve this.  If you have ideas on how to make it suck less, please let me know.
## TODO:
- Replace borrowed phoenix code
- Support procfiles?
- Better "waiting":
  - Check for open port, or file existence, etc
