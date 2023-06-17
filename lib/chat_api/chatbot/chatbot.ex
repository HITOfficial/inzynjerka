defmodule ChatApi.Chatbot do
  alias ChatApi.Messages.Message

  @type chatbot_request :: %{ body: String.t(), conversation_id: String.t(), account_id: String.t() }

  @spec get_chatbot_response(chatbot_request) :: {:ok, String.t()} | {:error, :confidence_too_low}
  def get_chatbot_response(%{body: body, conversation_id: conversation_id, account_id: account_id}) do
    # random number between 0 and 1
    random_number = :rand.uniform()
    if random_number < 0.5 do
      {:ok, "Hello, I'm a chatbot!"}
    else
      {:error, :confidence_too_low}
    end
  end
end
