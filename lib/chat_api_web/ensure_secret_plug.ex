defmodule ChatApiWeb.EnsureSecretPlug do
  import Plug.Conn, only: [halt: 1, put_status: 2]

  alias Phoenix.Controller
  alias Plug.Conn
  alias Pow.{Plug, Config}

  use Application

  def init(default), do: default
  def call(conn, _default) do
    [sent_secret] = Conn.get_req_header(conn, "secret")
    secret = Application.get_env(:chat_api, :service_secret)
    IO.inspect "TESTTEST"
    IO.inspect sent_secret
    IO.inspect secret
    IO.inspect conn
    case secret do
      nil ->
        conn
        |> put_status(500)
        |> Controller.json(%{error: %{status: 500, message: "Service secret is not configured"}})
        |> halt()
      _ ->
        if sent_secret == secret do
          conn
        else
          maybe_halt(conn)
        end
    end
  end

  defp maybe_halt(conn) do
    conn
    |> put_status(401)
    |> Controller.json(%{error: %{status: 401, message: "Unauthorized access"}})
    |> halt()
  end
end
