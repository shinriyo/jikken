defmodule Jikken.Repo do
  use Ecto.Repo, otp_app: :jikken, adapter: Sqlite.Ecto
end
