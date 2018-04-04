defmodule Depot.Filesystem do
  use GenServer

  def start_link(config) do
    GenServer.start_link(__MODULE__, config, Keyword.get(config, :otp, []))
  end

  def init(args) do
    state =
      %{}
      |> Map.put(:adapter, Keyword.fetch!(args, :adapter))

    if not Code.ensure_loaded?(state.adapter) do
      raise ArgumentError, "Adapter invalid or unavailable: #{inspect(state.adapter)}!"
    end

    config =
      if function_exported?(state.adapter, :start_link, 1) do
        {:ok, pid} = state.adapter.start_link([])
        %{pid: pid}
      else
        %{}
      end

    {:ok, Map.put(state, :config, config)}
  end

  def write(pid, path, contents) do
    GenServer.call(pid, {:write, {path, contents}})
  end

  def read(pid, path) do
    GenServer.call(pid, {:read, {path}})
  end

  def handle_call({:write, {path, contents}}, _from, %{adapter: adapter, config: config} = state) do
    {:reply, adapter.write(path, contents, config), state}
  end

  def handle_call({:read, {path}}, _from, %{adapter: adapter, config: config} = state) do
    {:reply, adapter.read(path, config), state}
  end
end