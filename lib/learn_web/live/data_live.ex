defmodule LearnWeb.DataLive do
  use LearnWeb, :live_view

  # set alias
  alias Learn.{Repo, Product}

  # on page load
  def mount(_params, _session, socket) do
    # get all data from product.ex which retrieved data from products table
    products = Repo.all(Product)
    # create an empty form
    form_field = %{"name" => "", "serial" => "", "price" => ""}
    # add data to socket
    socket = assign(socket, form: to_form(form_field), products: products)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <!-- loop through all products and show details -->
    <div :for={product <- @products}>
      <span>{product.name}</span>
      <span>{product.serial}</span>
      <span>{product.price}</span>
    </div>

    <!-- form for :form specified in mount -->
    <!-- on clicking the button in the form, the save event handle triggers -->
    <.form id="product" for={@form} phx-submit="save">
      <!-- with validate, it check inputs -->
      <!-- <.form id="product" for={@form} phx-submit="save" phx-change="validate"> -->
      <span>Name</span>
      <.input type="text" field={@form[:name]} />
      <span>serial</span>
      <.input type="text" field={@form[:serial]} />
      <span>price</span>
      <.input type="text" field={@form[:price]} />
      <button>Save</button>
    </.form>
    """
  end

  # on saving
  def handle_event("save", params, socket) do
    # create a changeset
    changeset = Product.changeset(%Product{}, params)

    # insert the changeset, either allowed or error
    case Repo.insert(changeset) do
      {:ok, _product} ->
        # get all products in database after insert
        products = Repo.all(Product)
        # clear the form
        form = to_form(%{"name" => "", "serial" => "", "price" => ""}, as: "product")

        # update socket with products and clear form
        socket =
          socket
          |> assign(:products, products)
          |> assign(:form, form)

        {:noreply, socket}

      # upon error, return changeset errors
      {:error, changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  # when something is entered in the form, it will validate if a value is allowed
  def handle_event("validate", params, socket) do
    mapped = Map.get(params, "product", params)

    # create a changeset
    changeset =
      %Product{}
      # map params
      |> Product.changeset(mapped)
      # Ensures errors appear in form
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, form: to_form(changeset, as: "product", id: "product"))}
  end
end
