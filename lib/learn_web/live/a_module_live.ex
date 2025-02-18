defmodule LearnWeb.AModuleLive do
  use LearnWeb, :live_component

  def render(assigns) do
    ~H"""
    <h1>A live module with passing data: {@data}</h1>
    """
  end
end
