defmodule Rockelivery.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params_create [:name, :age, :address, :cep, :cpf, :email, :password]
  @required_params_update @required_params_create -- [:password]

  @derive {Jason.Encoder, only: [:id, :age, :cpf, :address, :email]}

  schema "users" do
    field :age, :integer
    field :name, :string
    field :address, :string
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> changes(@required_params_create, params)
  end

  def changeset(struct, params) do
    struct
    |> changes(@required_params_update, params)
  end

  def changes(struct, permitted_fields, params) do
    struct
    |> cast(params, permitted_fields)
    |> validate_required(permitted_fields)
    |> validate_length(:password, min: 6)
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = user_cs) do
    change(user_cs, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(user_cs), do: user_cs
end
