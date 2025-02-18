defmodule Learn.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LearnWeb.Telemetry,
      Learn.Repo,
      {DNSCluster, query: Application.get_env(:learn, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Learn.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Learn.Finch},
      # Start a worker by calling: Learn.Worker.start_link(arg)
      # {Learn.Worker, arg},
      # Start to serve requests, typically the last entry
      LearnWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Learn.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LearnWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
