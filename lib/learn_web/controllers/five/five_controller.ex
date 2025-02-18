defmodule LearnWeb.FiveController do
  use LearnWeb, :controller

  @variables [
    %{nr: "1", obj: "object 1"},
    %{nr: "2", obj: "object 2"},
    %{nr: "3", obj: "object 3"}
  ]

  # function for route /five
  def home(conn, _params) do
    render(conn, :five, variables: @variables)
  end

  # function for route /five/:id
  # for the parameters it pattern matches and looks for id. the value is store under variable id and query and is assigned
  # so localhost:4000/five/1?number=2 will use this function
  def number(conn, %{"id" => id, "number" => query}) do
    conn
    |> assign(:id, id)
    |> assign(:query, query)
    |> render(:number)
  end

  # fallback if only id is present
  # so localhost:4000/five/1 will use this function
  def number(conn, %{"id" => id}) do
    conn
    |> assign(:id, id)
    |> assign(:query, nil)
    |> render(:number)
  end
end
