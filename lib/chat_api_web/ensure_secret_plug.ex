defmodule ChatApiWeb.EnsureSecretPlug do
  @moduledoc """
  This plug ensures that a user has a particular role.

  ## Example

      plug ChatApiWeb.EnsureRolePlug, [:user, :admin]

      plug ChatApiWeb.EnsureRolePlug, :admin

      plug ChatApiWeb.EnsureRolePlug, ~w(user admin)a
  """
  import Plug.Conn, only: [halt: 1, put_status: 2]

  alias Hex.Application
  alias Phoenix.Controller
  alias Plug.Conn
  alias Pow.{Plug, Config}

  def init(default), do: default

  @doc false
  @spec call(Conn.t(), any()) :: Conn.t()
  def call(conn, _default) do
    sent_secret = Conn.get_req_header(conn, "authorization")
    secret = Application.get_env(:chat_api, :service_secret)

    secret == sent_secret |> maybe_halt(conn)
  end

  defp maybe_halt(true, conn), do: conn

  defp maybe_halt(_any, conn) do
    # TODO: figure out a better way to handle this
    conn
    |> put_status(401)
    |> Controller.json(%{error: %{status: 401, message: "Unauthorized access"}})
    |> halt()
  end
end
