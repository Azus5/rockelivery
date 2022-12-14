defmodule Rockelivery.Users.Get do
  alias Rockelivery.{Error, User, Repo}

  # Using with
  # def by_id2(id) do
  #   with {:ok, uuid} <- UUID.cast(id),
  #        %User{} = user <- Repo.get(User, uuid) do
  #     {:ok, user}
  #   else
  #     :error -> {:error, %{status: :bad_request, result: "Please provide a valid UUID!"}}
  #     nil -> {:error, %{status: :not_found, result: "User not found!"}}
  #   end
  # end

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.resource_not_found()}
      user -> {:ok, user}
    end
  end
end
