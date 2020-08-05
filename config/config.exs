# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :vin_service,
  ecto_repos: [VinService.Repo]

# Configures the endpoint
config :vin_service, VinServiceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QKte8aFd+K6HTHyNSN8JsVs5+EZJasRx8nFvl7WRShMdS19Woo+qvn8dfDqQkUGs",
  render_errors: [view: VinServiceWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: VinService.PubSub,
  live_view: [signing_salt: "bkz7bIM3"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
