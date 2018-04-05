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

  def update(path, contents, config) do
    full_path = resolve_path(path, config)

    if File.exists?(full_path) do
      write(path, contents, config)
    else
      {:error, :enoent}
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

  def delete(path, config) do
    full_path = resolve_path(path, config)
    File.rm(path)
  end

  defp resolve_path(path, %{root: root}), do: Path.join(root, path)
  defp resolve_path(path, _), do: path
end
