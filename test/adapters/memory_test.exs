defmodule Depot.Adapters.MemoryTest do
  use ExUnit.Case
  alias Depot.Adapters.Memory

  test "files which are written can be read again" do
    {:ok, pid} = Memory.start_link()

    path = "in/memory/test.txt"

    Memory.write(path, "Some content", %{pid: pid})

    assert {:ok, "Some content"} = Memory.read(path, %{pid: pid})
  end
end
