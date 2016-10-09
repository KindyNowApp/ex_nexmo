defmodule ExNexmo.SMS.Nexmo do

  @moduledoc """
  Delivers a request payload to the Nexmo API and returns a parsed response.
  """

  alias ExNexmo.Config
  alias ExNexmo.SMS.Response

  @headers [{"content-type", "application/json; charset=utf-8"}]

  @doc """
  Posts the message payload to the API.
  """
  @spec deliver(Request.t) :: {atom, Response.t} | {atom, String.t}
  def deliver(payload) do
    Config.base_url
    |> HTTPoison.post(payload, @headers)
    |> handle_send_reponse
  end

  @spec handle_send_reponse({atom, HTTPoison.Response.t}) :: {atom, Response.t} | {atom, String.t}
  defp handle_send_reponse({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    {:ok, Response.parse(body)}
  end

  defp handle_send_reponse({:error, %HTTPoison.Error{id: _id, reason: reason}}) do
    {:error, reason}
  end

end
