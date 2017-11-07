defmodule ExNexmo.Config do

  @moduledoc """
  Configuration module which handles config variables used for Nexmo's API.
  """

  @doc """
  Gets the Nexmo API key from an environment variable.
  """
  def api_key, do: Application.get_env(:ex_nexmo, :api_key, System.get_env("NEXMO_API_KEY"))

  @doc """
  Gets the Nexmo API secret from an environment variable.
  """
  def api_secret, do: Application.get_env(:ex_nexmo, :api_secret, System.get_env("NEXMO_API_SECRET"))

  @doc """
  Gets the Nexmo API host from the application config.
  """
  def api_host, do: Application.get_env(:ex_nexmo, :api_host, "https://rest.nexmo.com")

  @doc """
  Gets the base URL for the Nexmo SMS service.
  """
  def base_url, do: api_host() <> "/sms/json"

  @doc """
  Checks whether to use local preview.
  """
  def use_local, do: Application.get_env(:ex_nexmo, :use_local, false)

end
