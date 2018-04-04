defmodule Depot.FilesystemTest do
  use ExUnit.Case
  alias Depot.Filesystem

  setup do
    File.mkdir_p!("test/fixture/write")

    on_exit(fn ->
      File.rm_rf!("test/fixture/write")
      File.mkdir_p!("test/fixture/write")
    end)
  end

  for adapter <- [Depot.Adapters.Local, Depot.Adapters.Memory] do
    test "#{inspect(adapter)}: files which are written can be read again" do
      {:ok, pid} = Filesystem.start_link(adapter: unquote(adapter))

      path = "test/fixture/write/test.txt"

      Filesystem.write(pid, path, "Some content")

      assert {:ok, "Some content"} = Filesystem.read(pid, path)
    end

    test "#{inspect(adapter)}: reading unavailable files results in an error" do
      {:ok, pid} = Filesystem.start_link(adapter: unquote(adapter))

      assert {:error, _} = Filesystem.read(pid, "test/fixture/write/test.txt")
    end

    test "#{inspect(adapter)}: it can report if a file does exist" do
      {:ok, pid} = Filesystem.start_link(adapter: unquote(adapter))

      path = "test/fixture/write/test.txt"

      assert Filesystem.has(pid, path) == false

      Filesystem.write(pid, path, "Some content")

      assert Filesystem.has(pid, path) == true
    end
  end

  test "config is passed to adapter" do
    {:ok, pid} =
      Filesystem.start_link(
        adapter: Depot.Adapters.Local,
        config: %{
          root: "test/fixture/write"
        }
      )

    path = "test.txt"

    Filesystem.write(pid, "test.txt", "Some content")

    assert {:ok, "Some content"} = Filesystem.read(pid, "test.txt")
    assert {:ok, "Some content"} = File.read("test/fixture/write/test.txt")
  end
end
