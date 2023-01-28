
local Config = {
    VehDensity = 0.0, -- How many vehicles are driving (0.0 - 1.0) | The lower the number the less cars
    PedDensity = 0.0, -- How many AI are around (0.0 - 1.0) | The lower the number the less AI
    RanVehDensity = 0.0, -- How many Random Cars (0.0 - 1.0) | The lower the number the less cars
    ParkCarDensity = 0.0, -- How many parked cars (0.0 - 1.0) | The lower the number the less cars
    ScenePedDensity = 0.0 -- How many AI doing emotes (scenarios) (0.0 - 1.0) | The lower the number the less AI
}

Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(0)
	    SetVehicleDensityMultiplierThisFrame(Config.VehDensity)
	    SetPedDensityMultiplierThisFrame(Config.PedDensity)
	    SetRandomVehicleDensityMultiplierThisFrame(Config.RanVehDensity)
	    SetParkedVehicleDensityMultiplierThisFrame(Config.ParkCarDensity)
	    SetScenarioPedDensityMultiplierThisFrame(Config.ScenePedDensity, Config.ScenePedDensity)
    end
end)

