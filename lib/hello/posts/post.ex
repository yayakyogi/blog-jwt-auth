defmodule Hello.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.Accounts.User

  schema "posts" do
    field :title, :string
    field :body, :string
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
    |> validate_length(:title, min: 1)
    |> validate_length(:body, min: 1)
  end
end
