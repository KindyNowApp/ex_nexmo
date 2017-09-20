defmodule ExNexmo do

  @moduledoc """
  A Nexmo API client for Elixir.

  You can find the hex package [here](https://hex.pm/packages/ex_nexmo), and the docs [here](http://hexdocs.pm/ex_nexmo).

  ## Usage

  ```elixir
  def deps do
    [{:ex_nexmo, "~> 0.1"}]
  end
  ```

  Add the `:ex_nexmo` application as your list of applications in `mix.exs`:

  ```elixir
  def application do
    [applications: [:logger, :ex_nexmo]]
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

  ## Message preview in the browser

  ExNexmo includes a Plug that allows for preview of sent messages in the
  browser. A sample of the required config is in `config/dev.exs`:

  ```elixir
  use Mix.Config

  config :ex_nexmo, use_local: true
  ```

  Setting the `use_local` config option will cause messages to be stored locally
  in-memory, allowing you to see what would have been sent to the recipient.

  If you're using Phoenix, for example, you could use it like this:

  ```elixir
  # in web/router.ex
  if Mix.env == :dev do
    scope "/dev" do
      pipe_through [:browser]
      forward "/sms", Plug.ExNexmo.MessagePreview, [base_path: "/dev/sms"]
    end
  end
  ```
  """

  use Application
  alias ExNexmo.Config
  alias ExNexmo.SMS.{Request, Local}

  def start(_, _) do
    import Supervisor.Spec, warn: false

    children = if Config.use_local do
      [worker(Local, [])]
    else
      []
    end
    opts = [strategy: :one_for_one, name: ExNexmo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @spec send_sms(String.t, String.to, String.t) :: {atom, map}
  def send_sms(from, to, text) do
    Request.send(from, to, text)
  end

  @spec send_sms(String.t, String.to) :: {atom, map}
  def send_sms(to, text) do
    Request.send(to, text)
  end

end
