defmodule ExNexmo.SMS.Request do

  @moduledoc """
  TODO
  """

  alias ExNexmo.Config
  alias ExNexmo.SMS.Response
  import Poison, only: [encode: 1]
  @headers [{"content-type", "application/json; charset=utf-8"}]

  @doc """
  Send the SMS message.
  """
  @spec send(String.t, String.to, String.t) :: {atom, map}
  def send(from, to, text) do
    {:ok, payload} =
      from
      |> build_payload(to, text)
      |> encode
    Config.base_url
    |> HTTPoison.post(payload, @headers)
    |> handle_send_reponse
  end

  @doc """
  Builds a request payload.
  """
  @spec build_payload(String.t, String.t, String.t) :: map
  def build_payload(from, to, text) do
    %{
      api_key: Config.api_key,
      api_secret: Config.api_secret,
      from: from,
      to: to,
      text: text
    }
  end

  defp handle_send_reponse({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    {:ok, Response.parse(body)}
  end

  defp handle_send_reponse({:error, %HTTPoison.Error{id: _id, reason: reason}}) do
    {:error, reason}
  end

end
