defmodule ChatApi.Chatbot do
  alias ChatApi.Messages.Message

  @type chatbot_request :: %{ body: String.t(), conversation_id: String.t(), account_id: String.t() }

  @spec get_chatbot_response(chatbot_request) :: {:ok, String.t()} | {:error, :confidence_too_low}
  def get_chatbot_response(%{body: body, conversation_id: conversation_id, account_id: account_id}) do
    response =  HTTPoison.post("127.0.0.1:8080/chatbot", Jason.encode!(%{ message: body }), [{"Content-Type", "application/json"}])
    IO.inspect response
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        response = Jason.decode!(body)
        %{"data" => data} = response
        {:ok, data["response"]}
      {:ok, %HTTPoison.Response{status_code: 404}} -> {:error, :not_found}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end
end
