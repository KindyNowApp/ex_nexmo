defmodule ExNexmo.Config do
  @moduledoc """
  Configuration module which handles config variables used for Nexmo's API.
  """

  def api_key, do: Application.get_env(:ex_nexmo, :api_key)
  def api_secret, do: Application.get_env(:ex_nexmo, :api_secret)

  def api_host, do: Application.get_env(:ex_nexm, :api_host) || "https://rest.nexmo.com"

  def base_url do
    api_host <> "/sms"
  end
end
