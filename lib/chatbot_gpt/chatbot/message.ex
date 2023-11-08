defmodule ChatbotGpt.Chatbot.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "chatbot_messages" do
    field :content, :string
    field :role, :string

    belongs_to :conversation, ChatbotGpt.Chatbot.Conversation

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :role])
    |> validate_required([:content])
  end
end
