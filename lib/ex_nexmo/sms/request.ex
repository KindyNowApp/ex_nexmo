defmodule ExNexmo.SMS.Request do

  @moduledoc """
  A request to the Nexmo SMS API.
  """

  alias __MODULE__
  alias ExNexmo.Config
  alias ExNexmo.SMS.{Response, Nexmo, Local}
  import Poison, only: [encode: 1]

  defstruct api_key: nil,
    api_secret: nil,
    from: nil,
    to: nil,
    text: nil,
    type: "text",
    status_report_req: 0,
    client_ref: nil,
    vcard: nil,
    vcal: nil,
    ttl: nil,
    callback: nil,
    message_class: nil,
    udh: nil,
    protocol_id: nil,
    body: nil,
    title: nil,
    url: nil,
    validity: nil

  @type t :: %__MODULE__{}

  @doc """
  Send the SMS message.
  """
  @spec send(String.t, String.to, String.t) :: {atom, map}
  def send(from, to, text) do
    %Request{from: from, to: to, text: text}
    |> send
  end

  @spec send(Request.t) :: {atom, map}
  def send(%Request{} = request) do
    request
    |> build_payload
    |> encode
    |> deliver
  end

  @doc """
  Builds a request payload.
  """
  @spec build_payload(Request.t) :: Request.t
  def build_payload(%Request{api_key: nil} = request) do
    build_payload(%Request{request | api_key: Config.api_key})
  end

  def build_payload(%Request{api_secret: nil} = request) do
    build_payload(%Request{request | api_secret: Config.api_secret})
  end

  def build_payload(request), do: request

  @spec deliver({atom, Request.t}) :: {atom, Response.t} | {atom, String.t}
  defp deliver({:ok, payload}) do
    adapter().deliver(payload)
  end

  @spec adapter :: atom
  defp adapter do
    if Config.use_local do
      Local
    else
      Nexmo
    end
  end

end
