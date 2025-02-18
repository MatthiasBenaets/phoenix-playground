defmodule LearnWeb.PageController do
  use LearnWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def one(conn, _params) do
    # A new page that uses the same controller.
    # it does use the general layout with
    # the app.html.heex and root.html.heex layout.
    # It also uses :home which can be found
    # under ./page_html/home.html.heex
    render(conn, :home)
  end
end
