defmodule ChatbotGpt.Chatbot do
  @moduledoc """
  The chatbot context.
  """
  import Ecto.Query, warn: false
  alias ChatbotGpt.Repo

  alias ChatbotGpt.Chatbot.Conversation
  alias ChatbotGpt.Chatbot.Message

  def list_chatbot_conversations() do
    Conversation
    |> Repo.all()
  end

  def create_conversation(attrs \\ %{}) do
    %Conversation{}
    |> Conversation.changeset(attrs)
    |> Repo.insert()
  end

  def update_conversation(%Conversation{} = conversation, attrs) do
    conversation
    |> Conversation.changeset(attrs)
    |> Repo.update()
  end

  def create_message(conversation, attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:conversation, conversation)
    |> Repo.insert()
  end

  def change_message(%Message{} = message, attrs \\ %{}) do
    Message.changeset(message, attrs)
  end

  def generate_response(conversation, messages) do
    last_five_messages =
      Enum.slice(messages, 0..4)
      |> Enum.map(fn %{role: role, content: content} ->
        %{"role" => role, "content" => content}
      end)
      |> Enum.reverse()

    create_message(conversation, ChatbotGpt.Chatbot.OpenaiService.call(last_five_messages))
  end
end
