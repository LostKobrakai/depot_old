defmodule Depot.Adapter do
  @moduledoc """
  Behaviour for `Depot` filesystem adapters.
  """
  @type config :: %{}
  @type path :: Path.t()

  @callback start_link(opts :: Keyword.t()) :: GenServer.on_start()

  @doc "Write contents to the file in path"
  @callback write(path, contents :: iodata, config) :: :ok | {:error, error :: term}

  # @doc "Update contents of the file in path"
  # @callback update(path, contents :: iodata, config) :: :ok | {:error, error :: term}

  # @doc "Write or update contents of the file in path"
  # @callback put(path, contents :: iodata, config) :: :ok | {:error, error :: term}

  @doc "Read the contents of the file in path"
  @callback read(path, config) :: {:ok, contents :: binary} | {:error, error :: term}

  @doc "Check if a file exists"
  @callback has(path, config) :: boolean

  # @doc "Delete the file in path"
  # @callback delete(path, config) :: :ok | {:error, error :: term}

  # @doc "Move or rename the file in path"
  # @callback move(original :: path, new :: path, config) :: :ok | {:error, error :: term}

  # @doc "Copy the file in path to another location"
  # @callback copy(original :: path, copy :: path, config) :: :ok | {:error, error :: term}

  # @doc "Set the visibility for the file in path"
  # @callback set_visibility(original :: path, visibility :: term, config) :: :ok | {:error, error :: term}

  # @doc "Retrieve the metadata of the file in path"
  # @callback get_metadata(path, config) :: term

  # @doc "Retrieve the mimetype of the file in path"
  # @callback get_mimetype(path, config) :: term

  # @doc "Retrieve the timestamp of the file in path"
  # @callback get_typestamp(path, config) :: term

  # @doc "Retrieve the size of the file in path"
  # @callback get_size(path, config) :: term

  # @doc "Retrieve the visibility of the file in path"
  # @callback get_visibility(path, config) :: term

  # @doc "Create a directory"
  # @callback create_dir(path, config) :: :ok | {:error, error :: term}

  # @doc "Delete a directory"
  # @callback delete_dir(path, config) :: :ok | {:error, error :: term}

  # @doc "Retrieve the contents of the directory in path"
  # @callback list_contents(path, recursive :: boolean, config) :: list(term)

  @optional_callbacks start_link: 1
end
