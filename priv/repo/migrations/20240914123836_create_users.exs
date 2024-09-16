defmodule Hello.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :password, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, :email)
    create unique_index(:users, :username)
  end
end
