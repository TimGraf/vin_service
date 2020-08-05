defmodule VinService.NhtsaClient do
    import ExConstructor
    require Logger

    defmodule NhtsaVinResposne do
        @derive Jason.Encoder
        defstruct Count: nil, Message: "", SearchCriteria: "", Results: []
        use ExConstructor
    end

    defmodule NhtsaVinResposneResults do
        @derive Jason.Encoder
        defstruct Value: "", ValueId: "", Variable: "", VariableId: nil
        use ExConstructor
    end

    defimpl Poison.Decoder, for: NhtsaVinResposne do
        def decode(payload, _options) do
            %{payload | Results: decode_results(payload)}
        end    

        defp decode_results(%NhtsaVinResposne{Results: results}) do
            Enum.map(results, &(populate_struct(%NhtsaVinResposneResults{}, &1)))
        end
    end

    def decode_vin(vin) do
        url = "https://vpic.nhtsa.dot.gov/api/vehicles/decodevin/#{vin}?format=json"

        Logger.debug("Querying NHTSA for VIN: #{vin}.")
        
        case HTTPoison.get(url) do
            {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
                vin_response = Poison.decode!(body, as: %NhtsaVinResposne{})
                {:ok, vin_response}
            {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
                Logger.error("Status Code: #{status_code} - Error Reason: #{body}")
                {:error, "#{status_code} - #{body}"}
            {:error, error} ->
                Logger.error("Error: #{error}")
                {:error, error}
        end
    end
end