defmodule LearnWeb.DataLive do
  use LearnWeb, :live_view

  # set alias
  alias Learn.{Repo, Product}

  def render(assigns) do
    ~H"""
    <!-- loop through all products and show details -->
    <div :for={product <- @products}>
      <span>{product.name}</span>
      <span>{product.serial}</span>
      <span>{product.price}</span>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    # get all data from product.ex which retrieved data from products table
    products = Repo.all(Product)
    # add data to socket
    socket = assign(socket, products: products)
    {:ok, socket}
  end
end
