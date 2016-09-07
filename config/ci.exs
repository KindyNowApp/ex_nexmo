use Mix.Config

config :ex_nexmo,
  api_key: System.get_env("NEXMO_API_KEY"),
  api_secret: System.get_env("NEXMO_API_SECRET")

