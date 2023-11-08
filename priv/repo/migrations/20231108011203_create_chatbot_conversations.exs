defmodule ChatbotGpt.Repo.Migrations.CreateChatbotConversations do
  use Ecto.Migration

  def change do
    create table(:chatbot_conversations, primary_key: false) do
      add :id, :binary_id, primary_key: true

      timestamps()
    end
  end
end
