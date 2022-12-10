defmodule Rockelivery.Users.Delete do
  alias Rockelivery.{Error, User, Repo}

  defp by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.resource_not_found()}
      user -> Repo.delete(user)
    end
  end
end
