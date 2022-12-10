defmodule Rockelivery.Users.Update do
  alias Rockelivery.{Error, User, Repo}
  alias Ecto.UUID

  def call(%{"id" => id} = params) do
    case UUID.cast(id) do
      :error -> {:error, Error.invalid_uuid()}
      {:ok, _result} -> get_user(params)
    end
  end

  defp get_user(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, Error.resource_not_found()}
      user -> update(user, params)
    end
  end

  defp update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
