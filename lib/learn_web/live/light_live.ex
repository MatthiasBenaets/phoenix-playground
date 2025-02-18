defmodule LearnWeb.LightLive do
  use LearnWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, brightness: 10)
    # IO.inspect(socket)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Light</h1>
    <div id="light">
      <div class="meter w-full bg-gray-200 mb-10">
        <span
          class="flex bg-yellow-300 text-gray-800 transition-all duration-500 ease-in-out"
          style={"width: #{@brightness}%"}
        >
          {@brightness}
        </span>
      </div>
      <button phx-click="on" class="w-20 bg-yellow-300 text-gray-800">
        <span>on</span>
      </button>
      <button phx-click="off" class="w-20 bg-gray-800 text-white">
        <span>off</span>
      </button>
      <button phx-click="+" class="w-20 bg-green-200 text-gray-800">
        <span>+</span>
      </button>
      <button phx-click="-" class="w-20 bg-red-200 text-gray-800">
        <span>-</span>
      </button>
      <button phx-click="plus" class="w-20 bg-green-200 text-gray-800">
        <span>plus</span>
      </button>
      <button phx-click="min" class="w-20 bg-red-200 text-gray-800">
        <span>min</span>
      </button>
    </div>
    """
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, brightness: 100)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, brightness: 0)
    {:noreply, socket}
  end

  def handle_event("+", _, socket) do
    brightness = socket.assigns.brightness + 10
    socket = assign(socket, brightness: brightness)
    {:noreply, socket}
  end

  def handle_event("-", _, socket) do
    socket = update(socket, :brightness, &(&1 - 10))
    {:noreply, socket}
  end

  def handle_event("min", _, socket) do
    socket = update(socket, :brightness, &if(&1 > 0, do: &1 - 10, else: 0))
    {:noreply, socket}
  end

  def handle_event("plus", _, socket) do
    socket = update(socket, :brightness, &if(&1 < 100, do: &1 + 10, else: 100))
    {:noreply, socket}
  end
end
