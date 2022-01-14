defmodule EctoTechniques.Products do
    alias EctoTechniques.{Product, Repo}
    import Ecto.Query, only: [from: 2]

    def create_many_products(number \\ 5) do
        Enum.map(1..number, &build_product/1)
    end

    defp build_product(_) do
        price = Kernel.trunc(Faker.Commerce.price)
        %Product{
            name: Faker.Commerce.product_name,
            category: Faker.Commerce.department,
            price: price
        }
        |>  Repo.insert()
    end

    def get_products_using_concat do
        query = from p in Product,
        select: fragment("concat('Identificador: ', ?, ', Nome do produto: ', ?)", p.id, p.name)
        Repo.all(query)
    end

    def get_products_using_substring do
        query = from p in Product,
        select: fragment("substring(?, 1, 5)", p.name)
        Repo.all(query)
    end

    def get_products_using_replace do
        query = from p in Product,
        select: fragment("replace(?, 'r', '<(|)>')", p.name)
        Repo.all(query)
    end

    def get_products_with_uppercase do
        query = from p in Product,
        select: fragment("upper(?)", p.name)
        Repo.all(query)
    end

    def get_products_with_lowercase do
        query = from p in Product,
        select: fragment("lower(?)", p.name)
        Repo.all(query)
    end

    def get_products_using_reverse do
        query = from p in Product,
        select: fragment("reverse(upper(?))", p.name)
        Repo.all(query)
    end

    def get_products_using_upper_concat do
        query = from p in Product,
        select: fragment("upper(concat(?, ' ', ?))", p.name, p.price)
        Repo.all(query)
    end

    def get_products_using_length do
        query = from p in Product,
        select: %{chars: fragment("length(?)", p.name), product_name: p.name}
        Repo.all(query)
    end
end
