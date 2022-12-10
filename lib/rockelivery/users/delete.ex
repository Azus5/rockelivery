defmodule Rockelivery.Users.Delete do
  alias Rockelivery.{Error, User, Repo}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, Error.invalid_uuid()}
      {:ok, result} -> delete(result)
    end
  end

  defp delete(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.resource_not_found()}
      user -> Repo.delete(user)
    end
  end
end
