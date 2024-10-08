defmodule Hello.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.AuthTokens.AuthToken
  alias Hello.Posts.Post

  @derive {Jason.Encoder, except: [:__meta__, :auth_tokens, :password]}
  schema "users" do
    field :username, :string
    field :password, :string
    field :email, :string

    has_many :auth_tokens, AuthToken
    has_many :posts, Post

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> validate_length(:username, min: 2, max: 20)
    |> validate_length(:password, min: 8, max: 30)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> update_change(:email, fn email -> String.downcase(email) end)
    |> update_change(:username, &String.downcase(&1))
    |> hash_password
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} -> put_change(changeset, :password, Pbkdf2.hash_pwd_salt(password))
      _ -> changeset
    end
  end
end
