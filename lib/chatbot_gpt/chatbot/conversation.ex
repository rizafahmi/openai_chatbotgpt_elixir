defmodule ChatbotGpt.Chatbot.Conversation do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "chatbot_conversations" do
    field :resolved_at, :naive_datetime

    has_many :messages, ChatbotGpt.Chatbot.Message, preload_order: [desc: :inserted_at]

    timestamps()
  end

  @doc false
  def changeset(conversation, attrs) do
    conversation
    |> cast(attrs, [:resolved_at])
  end
end
