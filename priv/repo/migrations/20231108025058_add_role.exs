defmodule ChatbotGpt.Repo.Migrations.AddRole do
  use Ecto.Migration

  def change do
    alter table(:chatbot_messages) do
      add :role, :string
      add :content, :text
    end
  end
end
