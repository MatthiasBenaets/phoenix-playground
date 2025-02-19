defmodule LearnWeb.ChatLive do
  use LearnWeb, :live_view

  @topic "public"
  @event_new_message "new_message"

  def render(assigns) do
    ~H"""
    <div class="flex justify-center items-center h-full w-full">
      <!-- on page load when no name is set, let user pick name
      run set_name handle event on button click -->
      <form :if={@name == nil} phx-submit="set_name">
        <!-- svelte-ignore a11y-autofocus -->
        <input type="text" placeholder="Name" name="name" autofocus autocomplete="name" />
        <button class="py-2 px-2 bg-black text-white">Join</button>
      </form>
      
    <!-- when user give a name, load chat -->
      <div :if={@name} class="flex flex-col">
        <!-- load all messages, only loads the messages from user's side, messages not kept by agent -->
        <div :for={message <- @messages} class="w-full">
          <!-- conditional css -->
          <div class={"flex " <>
              if message["name"] == @name,
                do: "justify-end text-end",
                else: "justify-start text-start"
            }>
            <div class={"w-[90%] rounded-md " <> if message["name"] == @name, do: "bg-blue-600 text-white", else: "bg-slate-300 text-black"}>
              <span class={"text-xs " <> if message["name"] == @name, do: "font-bold", else: ""}>
                {message["name"]}
              </span>
              <span>{message["message"]}</span>
            </div>
          </div>
        </div>
        
    <!-- submit message, use handle_event send message -->
        <form phx-submit="send_message">
          <input
            type="text"
            placeholder="Message"
            name="message"
            autocomplete="message"
            phx-debounce="100"
          />
          <button class="py-2 px-2 bg-black text-white">Send</button>
        </form>
      </div>
    </div>
    """
  end

  # subscribe to chat topic
  def mount(_params, _session, socket) do
    LearnWeb.Endpoint.subscribe(@topic)
    # set message to empty and name to nil
    {:ok, assign(socket, messages: [], name: nil)}
  end

  # don't allow no name
  def handle_event("set_name", %{"name" => ""}, socket), do: {:noreply, socket}

  # save name
  def handle_event("set_name", %{"name" => name}, socket),
    do: {:noreply, assign(socket, name: name)}

  # send message
  def handle_event("send_message", payload, socket) do
    payload =
      payload
      |> Map.put("name", socket.assigns.name)
      |> Map.put(:id, System.unique_integer([:positive]))

    # broadcast new message to all subscribers
    LearnWeb.Endpoint.broadcast(@topic, @event_new_message, payload)

    {:noreply, socket}
  end

  # update messages when new message is posted, receive by the subcription
  def handle_info(%{topic: @topic, event: @event_new_message, payload: payload}, socket) do
    # take existing message and add new message
    {:noreply, assign(socket, messages: socket.assigns.messages ++ [payload])}
  end
end
