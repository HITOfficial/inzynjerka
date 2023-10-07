defmodule ChatApi.Chatbot do
  alias ChatApi.Messages.Message

  @type chatbot_request :: %{ body: String.t(), conversation_id: String.t(), account_id: String.t() }

  @spec get_chatbot_response(chatbot_request) :: %{ answer: String.t() | nil, send_to_human: boolean()}
  def get_chatbot_response(%{body: body, conversation_id: conversation_id, account_id: account_id}) do
    response =  HTTPoison.post("127.0.0.1:8080/chatbot", Jason.encode!(%{ message: body }), [{"Content-Type", "application/json"}])
    IO.inspect response
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        response = Jason.decode!(body)
        %{"data" => data} = response
        %{ answer: data["answer"], send_to_human: data["send_to_human"]}
      {:ok, %HTTPoison.Response{status_code: 404}} -> %{ answer: nil, send_to_human: true}
      {:error, %HTTPoison.Error{reason: reason}} -> %{ answer: nil, send_to_human: true}
    end
  end
end
