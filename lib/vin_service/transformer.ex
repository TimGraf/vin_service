defmodule VinService.VinTransfromer do
    alias VinService.Vehicle
    require Logger

    def transform_vin_from_repo(vin, vin_response) do
        results = vin_response["Results"]

        year = Enum.find(results, %{Value: ""}, fn r -> 
            r["Variable"] == "Model Year"
        end)
        make = Enum.find(results, %{Value: ""}, fn r -> 
            r["Variable"] == "Make"
        end)
        model = Enum.find(results, %{Value: ""}, fn r -> 
            r["Variable"] == "Model"
        end)
        trim = Enum.find(results, %{Value: ""}, fn r -> 
            r["Variable"] == "Trim"
        end)
        vehicle_type = Enum.find(results, %{Value: ""}, fn r -> 
            r["Variable"] == "Vehicle Type"
        end)
        drive_type = Enum.find(results, %{Value: ""}, fn r -> 
            r["Variable"] == "Drive Typer"
        end)

        %Vehicle{Year: year["Value"] || "", Make: make["Value"] || "", Model: model["Value"] || "", Trim: trim["Value"] || "", VehicleType: vehicle_type["Value"] || "", DriveType: drive_type["Value"] || "", Vin: vin}
    end

    def transform_vin_from_nhtsa(vin, vin_response) do
        results = vin_response."Results"

        year = Enum.find(results, %{Value: ""}, fn r -> 
            r."Variable" == "Model Year"
        end)
        make = Enum.find(results, %{Value: ""}, fn r -> 
            r."Variable" == "Make"
        end)
        model = Enum.find(results, %{Value: ""}, fn r -> 
            r."Variable" == "Model"
        end)
        trim = Enum.find(results, %{Value: ""}, fn r -> 
            r."Variable" == "Trim"
        end)
        vehicle_type = Enum.find(results, %{Value: ""}, fn r -> 
            r."Variable" == "Vehicle Type"
        end)
        drive_type = Enum.find(results, %{Value: ""}, fn r -> 
            r."Variable" == "Drive Typer"
        end)

        %Vehicle{Year: year."Value" || "", Make: make."Value" || "", Model: model."Value" || "", Trim: trim."Value" || "", VehicleType: vehicle_type."Value" || "", DriveType: drive_type."Value" || "", Vin: vin}
    end
end