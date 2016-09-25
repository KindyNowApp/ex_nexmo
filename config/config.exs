use Mix.Config

config :ex_nexmo,
  api_host: "https://rest.nexmo.com"

import_config "#{Mix.env}.exs"
