defmodule HelloWeb.AuthJSON do
  alias Hello.Accounts.User
  alias HelloWeb.PostJSON

  @doc """
    Check API
  """
  def message(%{success: success, message: message}) do
    %{success: success, message: message}
  end

  @doc """
    Renders response login.
  """
  def loginResponse(%{success: success, token: token}) do
    %{success: success, token: token}
  end

  @doc """
    Renders a single user.
  """
  def show(%{success: success ,user: user}) do
    %{success: success, user: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      posts: Enum.map(
                user.posts,
                fn post -> %{
                  id: post.id,
                  title: post.title,
                  body: post.body,
                  inserted_at: post.inserted_at
                }
                end
             )
    }
  end
end
