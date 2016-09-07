defmodule ConfigTest do
  use ExUnit.Case

  alias ExNexmo.Config

  doctest ExNexmo.Config

  setup do
    Application.put_env :ex_nexmo, :api_key, "test_key"
    Application.put_env :ex_nexmo, :api_secret, "test_secret"
  end

  test "api_key config returns correct value" do
    assert Config.api_key == "test_key"
  end

  test "api_secret config returns correct value" do
    assert Config.api_secret == "test_secret"
  end

  test "api_host config returns correct value" do
    assert Config.api_host == "https://rest.nexmo.com"
  end

  test "base_url config returns correct value" do
    assert Config.base_url == "https://rest.nexmo.com/sms"
  end
end
