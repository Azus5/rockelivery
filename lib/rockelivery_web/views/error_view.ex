defmodule RockeliveryWeb.ErrorView do
  use RockeliveryWeb, :view
  import Ecto.Changeset, only: [traverse_errors: 2]

  alias Ecto.Changeset

  def render("error.json", %{result: %Changeset{} = changeset}) do
    %{
      message: translate_errors(changeset)
    }
  end

  def render("error.json", %{result: result}) do
    %{
      message: result
    }
  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  defp translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
