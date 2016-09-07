defmodule ApiTest do
  use ExUnit.Case

  alias ExNexmo.Api
  alias ExNexmo.Config

  doctest ExNexmo.Api

  test "process_url returns correct url" do
    assert Api.process_url("/test") == Config.base_url <> "/test"
  end
end
