defmodule LearnWeb.FiveController do
  use LearnWeb, :controller

  # function for route /five
  def home(conn, _params) do
    render(conn, :five)
  end

  # function for route /five/:id
  # for the parameters it pattern matches and looks for id. the value is store under variable id and is assigned
  def number(conn, %{"id" => id}) do
    conn
    |> assign(:id, id)
    |> render(:number)
  end
end
