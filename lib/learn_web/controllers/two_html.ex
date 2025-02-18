defmodule LearnWeb.TwoHTML do
  @moduledoc """
  This module contains pages rendered by TwoController.

  See the `page_html` directory for all templates available.
  """
  use LearnWeb, :html

  # Will search for ./two_html/two.html.heex
  embed_templates "two_html/*"
end
