defmodule ExNexmo.Api do
  @moduledoc"""
  Client API Module to interact with Nexmo's API
  """

  use HTTPoison.Base

  alias ExNexmo.Config

  @endpoint Config.base_url

  def process_url(url) do
    @endpoint <> url
  end
end
