defmodule EctoTechniques.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string, nullable: false
      add :price, :integer
      add :category, :string, default: "stuff"

      timestamps()
    end

  end
end
