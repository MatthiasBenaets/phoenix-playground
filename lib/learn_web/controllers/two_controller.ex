defmodule LearnWeb.TwoController do
  @moduledoc """
  This is a new controller that is used in the router.
  In this example `TwoController :home` can be used.

  Next to the `TwoController`, a `TwoHTML` is required as well.
  """
  use LearnWeb, :controller

  # By specifying :two, it will use the `two.html.heex` template
  def home(conn, _params) do
    render(conn, :two)
  end
end
