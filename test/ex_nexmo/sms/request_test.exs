ExUnit.start

defmodule ExNexmo.SMS.RequestTest do
  use ExUnit.Case

  alias ExNexmo.SMS.{Request, Response}

  setup do
    api_key = "key"
    api_secret = "secret"
    to = "27820005555"
    from = "SenderId"
    text = "Test message"
    valid_single_message_response = """
{
  "message-count":"1",
  "messages":[
    {
    "status":"0",
    "message-id":"123",
    "to":"#{to}",
    "client-ref":"234234",
    "remaining-balance":"22344",
    "message-price":"345",
    "network":"network",
    "error-text":"error-message"
    }
  ]
}
    """
    failed_single_message_response = """
{
  "message-count":"1",
  "messages":[
    {
    "status":"5",
    "message-id":"123",
    "to":"#{to}",
    "client-ref":"234234",
    "remaining-balance":"22344",
    "message-price":"345",
    "network":"network",
    "error-text":"error-message"
    }
  ]
}
    """
    unknown_single_message_response = """
{
  "message-count":"1",
  "messages":[
    {
    "status":"5234",
    "message-id":"123",
    "to":"#{to}",
    "client-ref":"234234",
    "remaining-balance":"22344",
    "message-price":"345",
    "network":"network",
    "error-text":"error-message"
    }
  ]
}
    """
    bypass = Bypass.open
    orig_url = Application.get_env :ex_nexmo, :api_host
    url = "http://localhost:#{bypass.port}"
    Application.put_env :ex_nexmo, :api_host, url
    orig_api_key = System.get_env "NEXMO_API_KEY"
    System.put_env "NEXMO_API_KEY", api_key
    orig_api_secret = System.get_env "NEXMO_API_SECRET"
    System.put_env "NEXMO_API_SECRET", api_secret
    on_exit fn ->
      Application.put_env :ex_nexmo, :api_host, orig_url
      System.put_env "NEXMO_API_KEY", orig_api_key
      System.put_env "NEXMO_API_SECRET", orig_api_secret
    end
    {:ok, %{
      api_key: api_key,
      api_secret: api_secret,
      to: to,
      from: from,
      text: text,
      bypass: bypass,
      valid_single_message_response: valid_single_message_response,
      failed_single_message_response: failed_single_message_response,
      unknown_single_message_response: unknown_single_message_response
    }}
  end

  test "posts the request to Nexmo", %{
    from: from,
    to: to,
    text: text,
    bypass: bypass,
    valid_single_message_response: valid_single_message_response
  } do
    Bypass.expect bypass, fn conn ->
      assert "/sms/json" == conn.request_path
      assert "" == conn.query_string
      assert "POST" == conn.method
      assert {"content-type", "application/json; charset=utf-8"} in conn.req_headers
      Plug.Conn.resp(conn, 200, valid_single_message_response)
    end
    {:ok, %Response{messages: [%{status: status}]}} = Request.send(from, to, text)
    assert status == {:ok, :success}
  end

  test "returns the correct status for a failed message", %{
    from: from,
    to: to,
    text: text,
    bypass: bypass,
    failed_single_message_response: failed_single_message_response
  } do
    Bypass.expect bypass, fn conn ->
      assert "/sms/json" == conn.request_path
      assert "" == conn.query_string
      assert "POST" == conn.method
      assert {"content-type", "application/json; charset=utf-8"} in conn.req_headers
      Plug.Conn.resp(conn, 200, failed_single_message_response)
    end
    {:ok, %Response{messages: [%{status: status}]}} = Request.send(from, to, text)
    assert status == {:error, :internal_error}
  end

  test "returns the correct status for an unknown message", %{
    from: from,
    to: to,
    text: text,
    bypass: bypass,
    unknown_single_message_response: unknown_single_message_response
  } do
    Bypass.expect bypass, fn conn ->
      assert "/sms/json" == conn.request_path
      assert "" == conn.query_string
      assert "POST" == conn.method
      assert {"content-type", "application/json; charset=utf-8"} in conn.req_headers
      Plug.Conn.resp(conn, 200, unknown_single_message_response)
    end
    {:ok, %Response{messages: [%{status: status}]}} = Request.send(from, to, text)
    assert status == {:error, :unknown}
  end

  test "fails properly when connection fails", %{
    from: from,
    to: to,
    text: text,
    bypass: bypass
  } do
    Bypass.down(bypass)
    assert {:error, :econnrefused} == Request.send(from, to, text)
  end

end
