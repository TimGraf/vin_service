defmodule VinService.Repo.Migrations.CreateVinResponse do
  use Ecto.Migration

  def change do
    create table(:vin_response) do
      add :vin, :string
      add :reponse, :map

      timestamps()
    end

  end
end
