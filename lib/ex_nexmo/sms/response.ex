defmodule ExNexmo.SMS.Response do

  @moduledoc """
  TODO
  """

  alias ExNexmo.SMS.StatusCodes
  alias ExNexmo.Helper
  import Poison, only: [decode!: 1]

  @doc """
  Parses a Nexmo SMS response
  """
  @spec parse(String.t) :: map
  def parse(json_response) do
    response =
      json_response
      |> decode!
      |> Helper.atomise_keys
    Map.put(response, :messages, Enum.map(response[:messages], fn msg ->
      StatusCodes.parse_status_code(msg)
    end))
  end

end
