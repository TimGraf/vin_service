defmodule VinService.Vehicle do
    @derive Jason.Encoder
    defstruct Year: "", Make: "", Model: "", Trim: "", VehicleType: "", DriveType: "", Vin: ""
end