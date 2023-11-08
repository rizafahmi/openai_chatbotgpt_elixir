defmodule ChatbotGpt.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ChatbotGptWeb.Telemetry,
      # Start the Ecto repository
      ChatbotGpt.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ChatbotGpt.PubSub},
      # Start Finch
      {Finch, name: ChatbotGpt.Finch},
      # Start the Endpoint (http/https)
      ChatbotGptWeb.Endpoint
      # Start a worker by calling: ChatbotGpt.Worker.start_link(arg)
      # {ChatbotGpt.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ChatbotGpt.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChatbotGptWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
