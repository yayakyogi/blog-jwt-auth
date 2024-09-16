defmodule HelloWeb.PostController do
  use HelloWeb, :controller

  import Ecto.Query, warn: false
  alias Hello.Posts
  alias Hello.Posts.Post
  alias Hello.Repo

  action_fallback HelloWeb.FallbackController

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, :index, posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    res = Ecto.build_assoc(conn.assigns.current_user, :posts) |> Post.changeset(post_params)

    with changeset <- res , {:ok, %Post{} = post} <- Repo.insert(changeset) do
      render(conn, :show, post: post)
    else
      {:error, changeset} -> {:error, changeset}
    end
  end

  def show(conn, %{"id" => id}) do
    try do
      post = Posts.get_post!(id)
      render(conn, :show, post: post)
    rescue
      Ecto.NoResultsError -> {:error, :not_found}
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    try do
      post = Posts.get_post!(id)

      with{:ok, %Post{} = post} <- Posts.update_post(post, post_params) do
        render(conn, :show, post: post)
      end
    rescue
      Ecto.NoResultsError -> {:error, :not_found}
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      post = Posts.get_post!(id)

      with{:ok, %Post{}} <- Posts.delete_post(post) do
        send_resp(conn, :no_content, "")
      end
    rescue
      Ecto.NoResultsError -> {:error, :not_found}
    end
  end
end
