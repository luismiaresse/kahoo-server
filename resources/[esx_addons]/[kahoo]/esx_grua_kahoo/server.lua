
-- onResource start
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    Main()
end)


-- Comprueba el tiempo que llevan fuera los vehículos
function Main()
    while true do
        Wait(Config.Intervalo * 1000)
        local vehiculos = MySQL.query.await("SELECT * FROM owned_vehicles ov WHERE ov.stored = 0 and CURRENT_TIMESTAMP() - ov.time > "..Config.Limite);  
        print("Vehículos fuera de garaje demasiado tiempo: " .. #vehiculos)
        for i = 1, #vehiculos do
            local v = vehiculos[i]
            assert(v, "Error al obtener los vehículos fuera de garaje")
            local xPlayer  = ESX.GetPlayerFromIdentifier(v.owner)
            TriggerClientEvent('esx_grua_kahoo:checkVehicle', xPlayer.source, v, true)
        end

        local vehiculosAviso = MySQL.query.await("SELECT * FROM owned_vehicles ov WHERE ov.stored = 0 and CURRENT_TIMESTAMP() - ov.time > "..Config.Aviso);  
        print("Vehículos avisados fuera de garaje demasiado tiempo: " .. #vehiculosAviso)
        for i = 1, #vehiculosAviso do
            local v = vehiculosAviso[i]
            assert(v, "Error al obtener los vehículos fuera de garaje")
            local xPlayer  = ESX.GetPlayerFromIdentifier(v.owner)
            TriggerClientEvent('esx_grua_kahoo:checkVehicle', xPlayer.source, v, false)
        end

    end
end

RegisterServerEvent('esx_grua_kahoo:setImpound')
AddEventHandler('esx_grua_kahoo:setImpound', function(plate)
    print("Setting impound for plate "..plate)
    MySQL.execute("UPDATE owned_vehicles ov SET ov.stored = 2 WHERE ov.plate = @plate", {["@plate"] = plate})
    TriggerEvent('esx_grua_kahoo:resetTimer', plate)
end)

RegisterServerEvent('esx_grua_kahoo:resetTimer')
AddEventHandler('esx_grua_kahoo:resetTimer', function(plate)
    print("Resetting timer for plate "..plate)
    MySQL.execute("UPDATE owned_vehicles ov SET ov.time = CURRENT_TIMESTAMP() WHERE ov.plate = @plate", {["@plate"] = plate})
end)