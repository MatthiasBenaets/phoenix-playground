defmodule LearnWeb.PresLive do
  use LearnWeb, :live_view

  alias LearnWeb.Presence

  # presence people subscribe to
  @topic "lobby"
  # shared key used to track presence data, can also just use socket.id
  @key "lobbykey"

  def mount(_params, _session, socket) do
    # wait until socket is connected
    if connected?(socket) do
      # subscribe to lobby topic
      LearnWeb.Endpoint.subscribe(@topic)
      # adds liveview process to the presence tracking system
      Presence.track(self(), @topic, @key, %{})
    end

    # store number of connected
    {:ok, assign(socket, number_of_users: count_users())}
  end

  # show number connected
  def render(assigns) do
    ~H"""
    <div>
      {@number_of_users} user(s) connected
    </div>
    """
  end

  # function runs when a presence update happens. "presence_diff" is the event being handled.
  def handle_info(%{event: "presence_diff"}, socket) do
    # change to updated numberof users
    {:noreply, assign(socket, number_of_users: count_users())}
  end

  # function to count connected users by fetching metadata
  defp count_users do
    case Presence.get_by_key(@topic, @key) do
      # if no users are found, indicate atleast 1 person connected (since visitor is viewing is)
      [] -> 1
      # pattern matches to find metas. the value is passed to the lenght function to count users
      %{metas: users} -> length(users)
    end
  end
end
