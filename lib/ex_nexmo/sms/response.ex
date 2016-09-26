defmodule ExNexmo.SMS.Response do

  @moduledoc """
  TODO
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

  defp atomise_keys({:ok, response}) do
    Helper.atomise_keys(response)
  end

  @spec parse_messages(Response.t) :: Response.t
  defp parse_messages(%Response{messages: messages} = response) do
    %Response{response | messages: Enum.map(messages, &Message.parse/1)}
  end

end
