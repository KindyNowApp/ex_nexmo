defmodule ExNexmo.SMS.Response do

  @moduledoc """
  A response from the Nexmo SMS API.
  """

  alias __MODULE__
  alias ExNexmo.SMS.Message
  alias ExNexmo.Helper
  import Poison, only: [decode: 1]

  defstruct message_count: nil,
    messages: []

  @type t :: %__MODULE__{}

  @doc """
  Parses a Nexmo SMS response
  """
  @spec parse(String.t) :: map
  def parse(json_response) do
    response =
      json_response
      |> decode
      |> atomise_keys
    Response
    |> struct(response)
    |> parse_messages
  end

  @spec atomise_keys({atom, map}) :: map
  defp atomise_keys({:ok, response}) do
    Helper.atomise_keys(response)
  end

  @spec parse_messages(Response.t) :: Response.t
  defp parse_messages(%Response{messages: messages} = response) do
    %Response{response | messages: Enum.map(messages, &Message.parse/1)}
  end

end
