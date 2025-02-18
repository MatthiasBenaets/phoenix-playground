defmodule LearnWeb.FourLive do
  use LearnWeb, :live_view

  # set alias for other live component.
  alias LearnWeb.AModuleLive

  # render on page
  def render(assigns) do
    ~H"""
    <h1>Four</h1>

    <.live_component module={AModuleLive} id="1" data="DATA" />
    """
  end

  # code to run on loading
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
