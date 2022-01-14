defmodule EctoTechniques.Repo do
  use Ecto.Repo,
    otp_app: :ecto_techniques,
    adapter: Ecto.Adapters.Postgres
end
