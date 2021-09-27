defmodule Foreperson do
  @moduledoc false

  def stream(prefix) do
    %Foreperson.Formatter{prefix: prefix}
  end
end
