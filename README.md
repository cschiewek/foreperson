# Foreperson

Generic process runner.  Inspired by [foreman](https://github.com/ddollar/foreman) and [Phoenix endpoint watchers](https://hexdocs.pm/phoenix/Phoenix.Endpoint.html#module-runtime-configuration).

_Please don't use this in production.  It's meant for local development and testing only.  It's designed for convenience, not resiliency._

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `foreperson` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:foreperson, "~> 0.1.0"}
  ]
end
```

See the [`Foreperson`](https://github.com/cschiewek/foreperson/blob/main/lib/foreperson.ex#L2-L34) module doc for configuration options.

### Why?

I end up needing to run multiple instances of different versions of external dependencies for my Elixir apps. asdf is great for switching versions, but there's no great story for starting and stoping those processes.

I typically end up using docker-compose, but Docker on MacOS has some frustrating issues.  I've also used foreman in the passed to varying degrees of success. I was looking for a similar Elixir, but couldn't find anything, so here we are.

This is probably a terrible way to solve this.  If you have ideas on how to make it suck less, please let me know.
### TODO:
- Replace borrowed phoenix code
- Enable startup in seperate shell/process via mix task
- Support procfiles?
- Better "waiting":
  - Check for open port, or file existence, etc
