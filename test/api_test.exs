defmodule ApiTest do
  use ExUnit.Case

  alias ExNexmo.Api
  alias ExNexmo.Config

  doctest ExNexmo.Api

  setup do
    bypass = Bypass.open

    Application.put_env :ex_nexmo, :api_host, "http://localhost:#{bypass.port}"
    on_exit fn ->
      Application.delete_env :ex_nexmo, :api_host
    end

    Api.start

    {:ok, bypass: bypass}
  end

  test "process_url returns correct url" do
    assert Api.process_url("/test") == Config.base_url <> "/test"
  end

  test "Send message request", %{ bypass: bypass } do
    Bypass.expect bypass, fn conn ->
      assert "/sms/json" == conn.request_path
      assert "POST" == conn.method

      assert {"content-type", "application/json"} in conn.req_headers

      Plug.Conn.resp(conn, 200, ~s({
        "message-count": "1"
      }))
    end

    {:ok, response} = Api.send(%{ from: "1234", to: "2468" })
  end
end
