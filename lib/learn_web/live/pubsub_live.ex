# will automatically increment when someone loads the page.
defmodule LearnWeb.PubsubLive do
  use LearnWeb, :live_view

  # topic to broadcast and subscribe to
  @topic "counter"

  # on page load
  def mount(_params, _session, socket) do
    # when socket is connected
    if connected?(socket) do
      # subscribe to the topic
      Phoenix.PubSub.subscribe(Learn.PubSub, @topic)

      # Increment the counter and get the new value
      new_count = Learn.Counter.increment()

      # Broadcast the new count to all subscribers
      Phoenix.PubSub.broadcast(Learn.PubSub, @topic, {:new_count, new_count})

      {:ok, assign(socket, count: new_count)}
    else
      # For the initial static render, just get the current count
      {:ok, assign(socket, count: Learn.Counter.get())}
    end
  end

  # when clicking on the button
  def handle_event("increment", _params, socket) do
    # add 1 to counter
    new_count = Learn.Counter.increment()
    # broadcast new value
    Phoenix.PubSub.broadcast(Learn.PubSub, @topic, {:new_count, new_count})
    # load new value on page
    {:noreply, assign(socket, count: new_count)}
  end

  def handle_event("decrease", _params, socket) do
    new_count = Learn.Counter.decrease()
    Phoenix.PubSub.broadcast(Learn.PubSub, @topic, {:new_count, new_count})
    {:noreply, assign(socket, count: new_count)}
  end

  # when changes are detected update the value
  def handle_info({:new_count, new_count}, socket) do
    {:noreply, assign(socket, count: new_count)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Count: {@count}</h1>
      <button phx-click="increment">Increment</button>
      <button phx-click="decrease">Decrease</button>
    </div>
    """
  end
end
