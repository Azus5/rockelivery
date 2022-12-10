defmodule Rockelivery.Error do
  @keys [:status, :result]
  @enforce_keys @keys

  defstruct @keys

  def build(status, result) do
    %__MODULE__{
      status: status,
      result: result
    }
  end

  def resource_not_found, do: build(:not_found, "Resource not found")
  def invalid_uuid, do: build(:bad_request, "Please provide a valid UUID!")
end
