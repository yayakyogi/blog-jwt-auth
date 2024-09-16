defmodule HelloWeb.JWTAuthPlug do
  import Plug.Conn
  alias Hello.Accounts
  alias Hello.Accounts.User
  alias Hello.AuthTokens

  def init(opts), do: opts

  def call(conn, _) do
    bearer = get_req_header(conn, "authorization") |> List.first()

    if bearer == nil do
      conn |> put_status(401) |> halt
    else
      token = bearer |> String.split(" ") |> List.last()
      secret = "z2YhWroSFlX29UhOBiRxfr1LOtKjIQ1EOYIZFDz0+1U38oDdZGZdnxZ9HW4sE77w"
      signer = Joken.Signer.create("HS256", secret)

      with {:ok, %{"user_id" => user_id}} <-
        HelloWeb.JWTToken.verify_and_validate(token, signer),
        %User{} = user <- Accounts.get_user(user_id) do

        if AuthTokens.get_auth_token_by_token(token) != nil do
          conn |> put_status(401) |> halt
        else
          conn |> assign(:current_user, user)
        end
      else
        {:error, _reason} -> conn |> put_status(401) |> halt
        _ -> conn |> put_status(401) |> halt
      end
    end
  end
end
