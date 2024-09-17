defmodule HelloWeb.AuthController do
  use HelloWeb, :controller

  import Ecto.Query, warn: false
  import Plug.Conn
  alias Hello.Accounts
  alias Hello.Accounts.User
  alias HelloWeb.JWTToken
  alias Hello.AuthTokens.AuthToken
  alias Hello.Repo

  action_fallback HelloWeb.FallbackController

  def ping(conn, _params) do
    render(conn, :message, %{success: true, message: "Ping success"})
  end

  def register(conn, params) do
    with {:ok, %User{} = user} <- Accounts.create_user(params) do
      conn
      |> put_status(:created)
      |> render(:show, %{success: true, user: user})
    end
  end

  def login(conn, %{"username" => username, "password" => password}) do
    with %User{} = user <- Accounts.get_user_by_username(username), true <- Pbkdf2.verify_pass(password, user.password) do
      secret = "z2YhWroSFlX29UhOBiRxfr1LOtKjIQ1EOYIZFDz0+1U38oDdZGZdnxZ9HW4sE77w"
      signer = Joken.Signer.create("HS256", secret)
      extra_claims = %{user_id: user.id}

      {:ok, token, _claims} = JWTToken.generate_and_sign(extra_claims, signer)

      conn
      |> put_status(200)
      |> render(:loginResponse, %{success: true, token: token})
    else
      nil -> {:error, :not_found}
      false -> {:error, :unauthorized}
    end
  end

  def get(conn, _params) do
    IO.inspect(conn.assigns.current_user)
    render(conn, :show, %{success: true, user: conn.assigns.current_user})
  end

  def logout(conn, _params) do
    case Ecto.build_assoc(conn.assigns.current_user, :auth_tokens, %{token: get_token(conn)})
    |> Repo.insert!() do
      %AuthToken{} -> conn |> render(:message, %{success: false, message: "Logout"})
      _ -> conn |> render(:message, %{success: false, message: "Internal server error"})
    end
  end

  defp get_token(conn) do
    bearer = get_req_header(conn, "authorization") |> List.first()

    if bearer == nil do
      ""
    else
      bearer |> String.split(" ") |> List.last()
    end
  end
end
