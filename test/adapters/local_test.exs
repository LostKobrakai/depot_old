defmodule Depot.Adapters.LocalTest do
  use ExUnit.Case
  alias Depot.Adapters.Local

  setup do
    File.mkdir_p!("test/fixture/write")

    on_exit(fn ->
      File.rm_rf!("test/fixture/write")
      File.mkdir_p!("test/fixture/write")
    end)
  end

  test "files will be written to the local filesystem" do
    path = "test/fixture/write/test.txt"

    Local.write(path, "Some write content", %{})

    assert {:ok, "Some write content"} = File.read(path)
  end

  test "files will be read from the local filesystem" do
    assert {:ok, "Some read content"} = Local.read("test/fixture/read/test.txt", %{})
  end

  describe "root config" do
    test "files will be written to the local filesystem" do
      path = "test.txt"

      Local.write(path, "Some write content", %{root: "test/fixture/write"})

      assert {:ok, "Some write content"} = File.read("test/fixture/write/test.txt")
    end

    test "files will be read from the local filesystem" do
      assert {:ok, "Some read content"} = Local.read("test.txt", %{root: "test/fixture/read"})
    end
  end
end
