defmodule Rockelivery do
  defdelegate create_user(params), to: Rockelivery.Users.Create, as: :call
  defdelegate get_user_by_id(uuid), to: Rockelivery.Users.Get, as: :by_id
  defdelegate delete_user_by_id(uuid), to: Rockelivery.Users.Delete, as: :call
  defdelegate update_user(params), to: Rockelivery.Users.Update, as: :call
end
