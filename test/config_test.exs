ExUnit.start

defmodule ConfigTest do
  use ExUnit.Case

  alias ExNexmo.Config

  doctest ExNexmo.Config

  setup do
    api_key = "test_key"
    api_secret = "test_secret"
    orig_api_key = System.get_env "NEXMO_API_KEY"
    System.put_env "NEXMO_API_KEY", api_key
    orig_api_secret = System.get_env "NEXMO_API_SECRET"
    System.put_env "NEXMO_API_SECRET", api_secret
    on_exit fn ->
      System.put_env "NEXMO_API_KEY", orig_api_key
      System.put_env "NEXMO_API_SECRET", orig_api_secret
    end
  end

  test "api_key config returns correct value" do
    assert Config.api_key == "test_key"
  end

  test "api_secret config returns correct value" do
    assert Config.api_secret == "test_secret"
  end

  test "api_host config returns correct default value" do
    assert Config.api_host == "https://rest.nexmo.com"
  end

  test "base_url config returns correct value" do
    assert Config.base_url == "https://rest.nexmo.com/sms/json"
  end
end
