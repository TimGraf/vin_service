defmodule VinServiceWeb.VinController do
    use VinServiceWeb, :controller
    alias VinService.{Repo, VinResponse, NhtsaClient, VinTransfromer}
    require Logger

    def index(conn, _params) do
        vin_responses = Repo.all(VinResponse)
        json(conn, vin_responses)
    end

    def show(conn, %{"vin" => vin}) do
        repo_response = Repo.get_by(VinResponse, vin: vin)

        if repo_response == nil do
            Logger.debug("No response cached for VIN: #{vin}")

            {:ok, nhtsa_response} = NhtsaClient.decode_vin(vin)

            {:ok, _inserted} = Repo.insert(%VinResponse{vin: vin, response: nhtsa_response})

            vehicle = VinTransfromer.transform_vin_from_nhtsa(vin, nhtsa_response)

            json(conn, vehicle)
        else
            Logger.debug("Found cached response for VIN: #{vin}")

            vehicle = VinTransfromer.transform_vin_from_repo(vin, repo_response.response)

            json(conn, vehicle)
        end
    end
end