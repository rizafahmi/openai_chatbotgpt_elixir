defmodule ChatbotGpt.Chatbot.OpenaiService do
  defp default_system_prompt do
    """
    You are a chatbot that only answers questions about the programming language Elixir.
    Answer short with just a 1-3 sentences.
    If the question is about another programming language, make a joke about it.
    If the question is about something else, answer something like:
    "I don't know, it's not my cup of tea" or "I have no opinion about that topic".
    """
  end

  def call(prompts, opts \\ []) do
    %{
      "model" => "gpt-3.5-turbo",
      "messages" =>
        Enum.concat(
          [
            %{"role" => "system", "content" => default_system_prompt()}
          ],
          prompts
        ),
      "temperature" => 0.7
    }
    |> Jason.encode!()
    |> request(opts)
    |> parse_response()
  end

  defp parse_response({:ok, %Finch.Response{body: body}}) do
    messages =
      Jason.decode!(body)
      |> Map.get("choices", [])
      |> Enum.reverse()

    case messages do
      [%{"message" => message} | _] -> message
      _ -> "{}"
    end
  end

  defp parse_response(error) do
    error
  end

  defp request(body, _opts) do
    IO.puts("REQUEST")
    dbg(headers())

    Finch.build(:post, "https://api.openai.com/v1/chat/completions", headers(), body)
    |> Finch.request(ChatbotGpt.Finch)
  end

  defp headers() do
    [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer #{System.get_env("openai_api_key")}"}
    ]
  end
end
