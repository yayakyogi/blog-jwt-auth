defmodule HelloWeb.PostJSON do
  alias Hello.Posts.Post
  alias Hello.Accounts.User

  @doc """
  Renders a list of post.
  """
  def index(%{posts: posts}) do
    %{posts: for(post <- posts, do: data(post))}
  end

  @doc """
  Renders a single post.
  """
  def show(%{post: post}) do
    %{post: data(post)}
  end

  def data(%Post{} = post) do
    %{
      id: post.id,
      body: post.body,
      title: post.title,
      user: %{
        email: post.user.email,
        username: post.user.username
      },
      inserted_at: post.inserted_at
    }
  end
end
