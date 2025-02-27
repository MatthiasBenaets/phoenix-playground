# Learn Phoenix

First, set up a database:

- Run `docker run -p 5432:5432 -e POSTGRES_PASSWORD=password -d postgres`.

Then, install Phoenix:

- Run `mix archive.install hex phx_new`.

Create the project

- Run `mix phx.new Learn`.
- Flags can be added such as `--database <database>` and `--binary-id` for connecting to a database or enabling uuid primary keys. This project has been created with both.
- More info about creating a project can be found [here](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.New.html).

When a database has been added, check if the settings to connect to the database are correct. These settings can be found in [config/config.ex](config/config.ex).

- Afterward run `mix ecto.create`.

Ecto will automatically create the table for you.

If dependencies are not installed, run `mix deps.get` in the project directory. This command also needs to be ran after adding a dependency in [mix.exs](mix.exs).

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies.
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn More

- Official website: <https://www.phoenixframework.org/>
- Guides: <https://hexdocs.pm/phoenix/overview.html>
- Docs: <https://hexdocs.pm/phoenix>
- Forum: <https://elixirforum.com/c/phoenix-forum>
- Source: <https://github.com/phoenixframework/phoenix>

## Directory Structure

[hexdocs](https://hexdocs.pm/phoenix/directory_structure.html)

## Database

Before interacting with the database, we need to set it up.\
This can be done by generating a migration file.

To see, what needs to happen to the database, look in [priv/repo/migrations](/priv/repo/migrations).\
These are the actions that will be executed on the database.\
These are used to create, update, delete table, etc.

Phoenix makes it easy for us, you just need use a generator.\
You can find all [here](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.html).

Since we want to have a schema and create a migration ([info](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Schema.html)):

- Run `mix phx.gen.schema Product products price:float serial:unique name:enum:foo:bar:baz`
- This creates a `Product` schema, for the `products` table, which has a column `price` of type `float`, a column `serial` which is `unique`, mean values in this column can only exist once, and a column `name` which is a list (enum) where the value can only be one of the listed.
- If you want to reference another table, you can use the reference another table.

After running the command 2 files will be created:

- `/lib/learn/product.ex`: schema that can be used throughout the codebase. It also uses changeset to validate the data before it is inserted into the db.
- `/priv/repo/migrations/<date>_create_products.exs`: specifies what needs to be done on the database.

Afterwards run `mix ecto.migrate`, to run the migration.\
This will create the table and set everything up.

To interact with the database we use `Learn.Repo` which is in [lib/learn/repo.ex](lib/learn/repo.ex).
You can query the database table in the shell by running `Learn.Repo.all(Shop.Product)`. It's also possible to `alias Learn.Repo` and `alias Learn.Product` so you can just run `Repo.all(Product)`. These aliases can also just be stored and set up globally inside [.iex.exs](.iex.exs).

To insert data via the iex shell, you can run:

- create new product: `product = %Product{name: :foo, price: 1.99, serial: "1234"}`
- insert it table products: `Repo.insert(product)`
- you can also first check if it is valid using the changeset: `product = Product.changeset(%Product{}, %{name: :foo, price: 1.99, serial: "1235"})`

[Ecto Query cheat sheet](https://hexdocs.pm/ecto/3.10.1/crud.html)

## Presence

To enable presence, run `mix phx.gen.presence`.\
In [lib/learn/application.ex](lib/learn/applications), add `LearnWeb.presence` to the children.\
The command will create a channels directory inside learn_web by default.

To track presence, it's ideal to track a topic and have a key.\
More information about how to set it up, have a look at the comments in [lib/learn_web/live/pres_live.ex](lib/learn_web/live/pres_live.ex).

## LiveSvelte

[github](https://github.com/woutdp/live_svelte)

## Authentication

[hexdocs](https://hexdocs.pm/phoenix/mix_phx_gen_auth.html)

The command below will generate all required authentication code.
`Users` is the context (to interact with backend), `User` is the schema, and `users` is the (db) table.

- run `mix phx.gen.auth Users User users`

This will generate all the components, live views, migration files, etc.
Afterwards run `mix deps.get` and since we need to set up the database for this new data, also run `mix ecto.migrate`.

I sometimes might error out while compiling bcypt.\
Just remove the `_build` and `deps` directory. Restart the terminal, and run both commands again.

So the new files and edits:

- `lib/learn/users`: user and user_token schema from database. Documentation for all functions will be in these files.
- `lib/learn/users.ex`: functions to interact with database
- `lib/learn_web/components/layouts/root.html.heex`: a head to navigate for user login/registration
- `lib/learn_web/controllers/user_session_controller.ex`: login, user creation
- `lib/learn_web/live/`: all new liveviews required for authentication

After registration, you can also test the email (see router.ex).\
via [localhost:4000/dev/mailbox](http://localhost:4000/dev/mailbox) you can see what mails have been send, and a user can be confirmed.
