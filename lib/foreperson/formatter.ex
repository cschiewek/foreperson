defmodule Foreperson.Formatter do
  @moduledoc """
  Module that implements Collectable in order to prefix output destined for :stdio

  Basically the same as IO.stream(:stdio, :line), but with the prefix support.
  """
  defstruct prefix: nil

  defimpl Collectable do
    def into(%{prefix: prefix} = formatter) do
      {:ok, into(formatter, prefix)}
    end

    defp into(formatter, prefix) do
      fn
        :ok, {:cont, x} -> IO.write(:stdio, (prefix && "👷[#{prefix}] ") <> x)
        :ok, _ -> formatter
      end
    end
  end
end
