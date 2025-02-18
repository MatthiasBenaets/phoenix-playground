defmodule LearnWeb.SixLive do
  use LearnWeb, :live_view

  # render on page
  def render(assigns) do
    ~H"""
    <!-- lib/learn_web/components/core_components.ex -->
    <!-- https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html -->

    <LearnWeb.CoreComponents.button class="bg-green-900">
      Button
    </LearnWeb.CoreComponents.button>

    <.back navigate={~p"/"}>
      <.button class="bg-green-900">
        <.icon name="hero-home" />
      </.button>
    </.back>

    <!-- normal navigation (everything needs to reload) -->
    <.link href="/">home</.link>
    <!-- navigate to liveview, page is kept open  -->
    <.link navigate={~p"/"}>home</.link>
    <!-- patches current liveview -->
    <.link patch={~p"/"}>home</.link>
    """
  end

  # code to run on loading
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
