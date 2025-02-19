# This is the schema used throughout the codebase
# in an iex shell you can do something like this:
# iex> test = %Learn.Product{name: "foo", serial: "1234", price: 1.00}
# this will create a struct with the given values
defmodule Learn.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field :name, Ecto.Enum, values: [:foo, :bar, :baz]
    field :serial, :string
    field :price, :float

    timestamps(type: :utc_datetime)
  end

  # changeset is used for validation
  # runs before interacting with database
  # check if use is not passing invalid parameters to the db
  # in an iex shell you can also test entries with
  # iex> changeset1 = Learn.Product.changeset(%Learn.Product{}, %{price: 1.00, serial: "1234", name: "foo"})
  # you can then check if its valid again by `changeset1.valid?`
  # you can check the changes with `changeset1.changes`
  @doc false
  def changeset(product, attrs) do
    product
    # check if all fields are in attributes and if types are correct
    |> cast(attrs, [:price, :serial, :name])
    # check if fields are passed
    |> validate_required([:price, :serial, :name])
    # added extra, validate is serial is longer than 3 character
    |> format()
    |> validate_length(:serial, min: 4)
    # check is serial is actually unique
    |> unique_constraint(:serial)
  end

  defp format(changeset) do
    # get name from changeset and trim for trailing whitespace
    new_name =
      changeset.changes.serial
      |> String.trim()

    # ecto function to edit changes
    put_change(changeset, :serial, new_name)
  end
end
