
CreateThread(function()
    local config = {
        aiDensity = 0.0,
        vehicleDensity = 0.0
    }
    while true do
        Wait(0)
        SetPedDensityMultiplierThisFrame(config.aiDensity)
        SetVehicleDensityMultiplierThisFrame(config.vehicleDensity)
        SetScenarioPedDensityMultiplierThisFrame(config.aiDensity, config.aiDensity)
        SetParkedVehicleDensityMultiplierThisFrame(config.vehicleDensity)
        SetRandomVehicleDensityMultiplierThisFrame(config.vehicleDensity)
    end
end)

