defmodule LearnWeb.TwoHTML do
  @moduledoc """
  This module contains pages rendered by TwoController.

  See the `page_html` directory for all templates available.
  """
  use LearnWeb, :html

  # Will search for ./two_html/two.html.heex
  embed_templates "two_html/*"

  # Component "<.component_one name='something' />" can be used in the two.html.heex file
  def component_one(assigns) do
    ~H"""
    <h1>Component {@name}</h1>
    """
  end
end
