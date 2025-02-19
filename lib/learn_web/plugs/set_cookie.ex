defmodule LearnWeb.Plugs.SetCookie do
  import Plug.Conn

  # get the initial value passed. In this case "1"
  def init(default_value), do: default_value

  # function if a url is opened like "localhost:4000?cookie=2". value "2" will than be store in a cookie called "cookies" and make it available to use (assign).
  def call(%Plug.Conn{:params => %{"cookie" => id}} = conn, _default_value) do
    conn
    |> assign(:cookie, id)
    |> put_resp_cookie("cookies", id, max_age: 2_592_000)
  end

  # if a cookie is already set. in this case it will just return the value of the cookie and make it available for use.
  def call(%Plug.Conn{:cookies => %{"cookies" => id}} = conn, _default_value) do
    conn
    |> assign(:cookie, id)
  end

  # when no param of "cookie" in the url, set cookie "cookies" to the default value and make available for use.
  def call(%Plug.Conn{} = conn, default_value) do
    # cookie needs to be binary, so a string
    value = to_string(default_value)

    conn
    |> assign(:cookie, value)
    |> put_resp_cookie("cookies", value, max_age: 2_592_000)
  end
end
