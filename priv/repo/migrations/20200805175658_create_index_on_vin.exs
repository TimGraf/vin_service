defmodule VinService.Repo.Migrations.CreateIndexOnVin do
  use Ecto.Migration

  def up do
    create index("vin_response", [:vin], comment: "Index VIN")
  end
end
