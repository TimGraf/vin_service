defmodule VinService.VinResponse do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:vin, :response]}
  schema "vin_response" do
    field :response, :map
    field :vin, :string

    timestamps()
  end

  @doc false
  def changeset(vin_response, attrs) do
    vin_response
    |> cast(attrs, [:vin, :response])
    |> validate_required([:vin, :response])
  end
end
