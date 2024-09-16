defmodule Hello.AuthTokens.AuthToken do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.Accounts.User

  schema "auth_tokens" do
    field :token, :string
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(auth_token, attrs) do
    auth_token
    |> cast(attrs, [:token])
    |> validate_required([:token])
  end
end
