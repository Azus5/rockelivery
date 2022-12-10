defmodule RockeliveryWeb.UsersView do
  use RockeliveryWeb, :view

  alias Rockelivery.User

  def render("index.json", %{users: list}) when is_list(list) do
    %{
      users: list
    }
  end

  def render("show.json", %{user: %User{} = user}) do
    %{
      user: user
    }
  end

  def render("create.json", %{user: %User{} = user}) do
    %{
      message: "User created",
      user: user
    }
  end
end
