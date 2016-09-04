# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :jikken, Jikken.Repo,
  adapter: Sqlite.Ecto,
  database: "jikken.sqlite3"
  #adapter: Ecto.Adapters.Postgres,
  #database: "jikken_repo",
  #username: "user",
  #password: "pass",
  #hostname: "localhost"


# General application configuration
config :jikken,
  ecto_repos: [Jikken.Repo]

# Configures the endpoint
config :jikken, Jikken.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TwUFyHLUlksBFSYeqS8IA81F0Qhj+9joHKt1zviGafOT7iNatEIk8eEutwOHZIj8",
  render_errors: [view: Jikken.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Jikken.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
