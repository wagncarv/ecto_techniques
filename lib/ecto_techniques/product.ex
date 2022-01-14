defmodule EctoTechniques.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @params [:name, :price, :category]

  schema "products" do
    field :category, :string
    field :name, :string
    field :price, :integer

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, @params)
    |> validate_required(@params)
  end
end
