defmodule ChatbotGpt.Repo do
  use Ecto.Repo,
    otp_app: :chatbot_gpt,
    adapter: Ecto.Adapters.SQLite3
end
