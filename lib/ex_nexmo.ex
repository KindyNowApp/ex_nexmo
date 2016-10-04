defmodule ExNexmo do

  @moduledoc """
  A Nexmo API client for Elixir.

  You can find the hex package [here](https://hex.pm/packages/ex_nexmo), and the docs [here](http://hexdocs.pm/ex_nexmo).

  ## Usage

  ```elixir
  def deps do
    [{:ex_nexmo, "~> 0.1.0"}]
  end
  ```

  Then run `$ mix do deps.get, compile` to download and compile your dependencies.

  You'll need to set a few config parameters, some in your app config, some, like
  API credentials, we recommend keeping as environment viarables: take a look in
  the `lib/config.ex` file to see what is required.

  Then sending a text message is as easy as:

  ```elixir
  ExNexmo.send_sms(from, to, message)
  ```
  """

  @spec send_sms(String.t, String.to, String.t) :: {atom, map}
  def send_sms(from, to, text) do
    ExNexmo.SMS.Request.send(from, to, text)
  end

end
