defmodule ChatbotGpt.Repo.Migrations.CreateChatbotMessages do
  use Ecto.Migration

  def change do
    create table(:chatbot_messages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :conversation_id, references(:chatbot_conversations, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:chatbot_messages, [:conversation_id])
  end
end
