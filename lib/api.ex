defmodule ExNexmo.Api do
  @moduledoc"""
  Client API Module to interact with Nexmo's API
  """

  use HTTPoison.Base

  alias ExNexmo.Config
  alias __MODULE__

  @endpoint Config.base_url

  def process_url(url) do
    Config.base_url <> url
  end

  def send(message) do
    Api.post("", message)
  end

  defp process_request_body(body) do
    body
    |> Poison.encode!
  end

  defp process_request_headers(headers) do
    headers
    |> Keyword.put(:"Content-Type", "application/json")
  end
end
