defmodule Learn.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    # create table
    create table(:products, primary_key: false) do
      # an id is added by default because the project was created with flag --binary-id
      add :id, :binary_id, primary_key: true
      # the specified fields
      add :price, :float
      # when no type is set, it will default to string
      add :serial, :string
      add :name, :string

      timestamps(type: :utc_datetime)
    end

    # here you see that serial is a unique field
    create unique_index(:products, [:serial])
  end
end
