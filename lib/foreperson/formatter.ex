defmodule Foreperson.Formatter do
  @moduledoc false
  defstruct prefix: nil

  defimpl Collectable do
    def into(%{prefix: prefix} = formatter) do
      {:ok, into(formatter, prefix)}
    end

    defp into(formatter, prefix) do
      fn
        :ok, {:cont, x} -> IO.write(:stdio, "👷[#{prefix}] " <> x)
        :ok, _ -> formatter
      end
    end
  end
end
