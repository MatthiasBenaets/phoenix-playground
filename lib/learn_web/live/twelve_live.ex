defmodule LearnWeb.TwelveLive do
  use LearnWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:number, 10)}
  end

  # ~V is an alternative liveview DSL, it is possible to use svelte inside
  # path of imports is relative to assets/svelte/_build/
  def render(assigns) do
    ~V"""
    <script>
    import Example from '../Example.svelte'
    export let number = 10
    let amount = 1

    let calc1
    let calc2

    $: {
      calc1 = number + amount
      calc2 = number - amount
    }
    </script>

    <Example />

    <p>number: {number}</p>

    {calc2}
    <button phx-click="set_number" value={number - amount}>-{amount}</button>
    <input type="number" bind:value={amount} />
    <button on:click={number = number+amount} value={number + amount}>+{amount}</button>
    {calc1}
    """

    # if not using the livesvelt dsl, use ~H and use the LiveSvelte.svelte component.
    # since LiveSvelte is imported during install, you can just use <.svelte>
    # it is important to alwayas pass the socket. other props are optional
    # ~H"""
    # <.svelte name="Example" socket={@socket} />
    # """
  end

  # via the phx-click, this function is called. In this case, subtractions are done serverside.
  # additions are done client side.
  # this is what make livesvelte so powerful
  def handle_event("set_number", %{"value" => number}, socket) do
    {:noreply, assign(socket, :number, String.to_integer(number))}
  end
end
