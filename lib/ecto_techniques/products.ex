defmodule EctoTechniques.Products do
    alias EctoTechniques.{Product, Repo}
    import Ecto.Query, only: [from: 2]
    alias Ecto.Query

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

    def get_products_using_distinct do
        query = from p in Product,
        distinct: true,
        select: p.name
        Repo.all(query)
    end

    def get_products_using_order_by do
        query = from p in Product,
        select: [name: p.name, price: p.price],
        order_by: [desc: :name]
        Repo.all(query)
    end

    def get_products_using_limit do
        query = from p in Product,
        select: [name: p.name, price: p.price],
        order_by: [desc: :name],
        limit: 3
        Repo.all(query)
    end

    def using_where_like do
        query = from p in Product,
        select: p,
        where: like(p.name, "%r%")
        Repo.all(query)
    end

    def using_where_like_prefix(filter \\ "u") do
        filter = "%#{filter}%"
        query = from p in Product,
        select: p,
        where: like(p.name, ^filter)
        Repo.all(query)
    end

    def using_group_by do
        query = from p in Product,
        select: [name: p.name, category: p.category, price: p.price, quantity: count(p.name)],
        group_by: [p.category, p.price, p.name]
        Repo.all(query)
    end

    def using_min do
        query = from p in Product,
        select: [price: min(p.price), name: p.name, count: count(p.name)],
        limit: 10,
        group_by: [:price, :name]
        Repo.all(query)
    end

    def using_subquery do
        query = from p in Product,
        select: p,
        limit: 10,
        where: p.price in subquery(from sqp in Product, select: min(sqp.price))
        Repo.all(query)
    end
end
