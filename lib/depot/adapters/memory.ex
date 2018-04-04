defmodule Depot.Adapters.Memory do
  @moduledoc """
  In memory implementation of a (naive) filesystem. 

  Does currently store files in a large `%{Path.t() => binary}` map. This should 
  later be changed to an ordered set ets table.
  """
  use GenServer

  @behaviour Depot.Adapter

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, %{}, opts)
  end

  @doc false
  def init(args), do: {:ok, args}

  def write(path, contents, %{pid: pid} = config) do
    GenServer.call(pid, {:write, {path, contents, config}})
  end

  def read(path, %{pid: pid} = config) do
    GenServer.call(pid, {:read, {path, config}})
  end

  def handle_call({:write, {path, contents, _config}}, _from, state) do
    {:reply, :ok, Map.put(state, path, IO.iodata_to_binary(contents))}
  end

  def handle_call({:read, {path, _config}}, _from, state) do
    case Map.fetch(state, path) do
      :error -> {:reply, {:error, :enoent}, state}
      {:ok, contents} -> {:reply, {:ok, contents}, state}
    end
  end
end
