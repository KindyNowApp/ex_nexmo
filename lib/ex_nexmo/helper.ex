defmodule ExNexmo.Helper do

  @moduledoc """
  Some helper functions for dealing with the Nexmo API.
  """

  @doc """
  Converts map keys to underscored atoms.
  """
  @spec atomise_keys(any) :: map
  def atomise_keys(map) when is_map(map) do
    Enum.reduce(map, %{}, &atomise_key/2)
  end

  def atomise_keys(list) when is_list(list) do
    Enum.map(list, &atomise_keys/1)
  end

  def atomise_keys(not_a_map) do
    not_a_map
  end

  defp atomise_key({key, val}, map) when is_binary(key) do
    key =
      key
      |> Macro.underscore
      |> String.replace("-", "_")
      |> String.to_atom
    atomise_key({key, val}, map)
  end

  defp atomise_key({key, val}, map) do
    Map.put(map, key, atomise_keys(val))
  end

end
