defmodule ExNexmo.SMS.Message do

  @moduledoc """
  TODO
  """

  alias __MODULE__
  alias ExNexmo.SMS.StatusCodes

  defstruct status: nil,
    message_id: nil,
    to: nil,
    client_ref: nil,
    remaining_balance: nil,
    message_price: nil,
    network: nil,
    error_text: nil

  @type t :: %__MODULE__{}

  @spec parse(map) :: Message.t
  def parse(map) do
    Message
    |> struct(map)
    |> StatusCodes.parse_status_code
  end

end
