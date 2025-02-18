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
