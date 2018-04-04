defmodule Depot.Adapters.Local do
  @moduledoc """
  Adapter for the local filesystem using elixir's native `File` module.
  """
  @behaviour Depot.Adapter

  def write(path, contents, _config) do
    File.write(path, contents)
  end

  def read(path, _config) do
    File.read(path)
  end

  def has(path, _config) do
    File.exists?(path)
  end
end
