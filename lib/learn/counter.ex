defmodule Learn.Counter do
  # Agent used to store the value that can be used with pubsub
  use Agent

  # function that runs initially.
  # an agent just stores one value with in this case is 0 on start.
  # __MODULE__ just references the current module name (Learn.Counter)
  def start_link(_) do
    Agent.start_link(fn -> 0 end, name: __MODULE__)
  end

  # add one to the agent's value
  def increment do
    Agent.get_and_update(__MODULE__, fn count ->
      {count + 1, count + 1}
    end)
  end

  # subtract one to the agent's value
  def decrease do
    Agent.get_and_update(__MODULE__, fn count ->
      {count - 1, count - 1}
    end)
  end

  # get the current value
  def get do
    Agent.get(__MODULE__, & &1)
  end
end
