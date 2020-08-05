defmodule VinService.Repo.Migrations.RenameReponseField do
  use Ecto.Migration

  def up do
    rename table("vin_response"), :reponse, to: :response
  end
end
