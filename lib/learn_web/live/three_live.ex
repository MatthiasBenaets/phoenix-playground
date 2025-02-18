defmodule LearnWeb.ThreeLive do
  use LearnWeb, :live_view

  def mount(_params, _session, assigns) do
    {:ok, assign(assigns, :number, 0)}
  end

  def render(assigns) do
    ~H"""
    <h1>Three</h1>

    <button phx-click="increment">{@number}</button>
    """
  end

  def handle_event("increment", _, socket) do
    {:noreply, update(socket, :number, &(&1 + 1))}
  end
end
