defmodule Depot.Adapters.Local do
  @moduledoc """
  Adapter for the local filesystem using elixir's native `File` module.
  """
  @behaviour Depot.Adapter

  def write(path, contents, config) do
    path = resolve_path(path, config)
    dir = Path.dirname(path)

    with :ok <- File.mkdir_p(dir) do
      File.write(path, contents)
    end
  end

  def read(path, config) do
    path
    |> resolve_path(config)
    |> File.read()
  end

  def has(path, config) do
    path
    |> resolve_path(config)
    |> File.exists?()
  end

  defp resolve_path(path, %{root: root}), do: Path.join(root, path)
  defp resolve_path(path, _), do: path
end
