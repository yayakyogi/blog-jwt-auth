defmodule HelloWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use HelloWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: HelloWeb.ErrorHTML, json: HelloWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(html: HelloWeb.ErrorHTML, json: HelloWeb.ErrorJSON)
    |> render(:"401")
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    errors = format_errors(changeset.errors)
    IO.inspect(errors, label: "Errors")

    conn
    |> put_status(:unprocessable_entity)
    |> json(%{success: false, errors: errors})
  end

  defp format_errors(errors) do
    Enum.into(errors, %{}, fn {field, {message, _}} ->
      {field, message}
    end)
  end
end
