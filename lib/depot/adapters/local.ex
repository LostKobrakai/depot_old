defmodule Depot.Adapters.Local do
  @behaviour Depot.Adapter

  def write(path, contents, config) do
    File.write(path, contents)
  end

  def read(path, config) do
    File.read(path)
  end
end
