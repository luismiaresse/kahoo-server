

RegisterNetEvent('esx_grua_kahoo:checkVehicle')
AddEventHandler('esx_grua_kahoo:checkVehicle', function (v, limite)
    local found = false
    local plate = v.plate.." "   -- IMPORTANTE (Sino no son ==)
    local isInVehicle = IsPedInAnyVehicle(GetPlayerPed(-1), false)
    local actualVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)

    for vehicle in EnumerateVehicles() do
        if GetVehicleNumberPlateText(vehicle) ~= plate then
            goto continue      -- Salta al final del bucle
        end
        -- Si el jugador no está en el vehículo o el modelo del vehículo es distinto al que tiene el jugador
        if not isInVehicle or (isInVehicle and GetEntityModel(vehicle) ~= GetEntityModel(actualVehicle)) then
            if limite then
                SetEntityAsMissionEntity(vehicle, true, true)
                DeleteVehicle(vehicle)
                ESX.ShowNotification("Tu vehículo con matrícula [~r~"..v.plate.."~s~] ha sido incautado por inactividad. Puedes reclamarlo en [~o~vehículos incautados~s~] en cualquier garaje")
                -- TriggerClientEvent('chat:addMessage', -1, { args = { "[Grúa]", "^1Tu vehículo con matrícula [" .. plate .. "] ha sido incautado por inactividad^7" }, color = 255,255,255 })
                TriggerServerEvent('esx_grua_kahoo:setImpound', v.plate)
            else
                ESX.ShowNotification("Tu vehículo con matrícula [~r~"..v.plate.."~s~] está cerca de incautarse por inactividad. Guárdalo antes de que ocurra.")
            end
            found = true
            break
        elseif isInVehicle and GetEntityModel(vehicle) == GetEntityModel(actualVehicle) then
            TriggerServerEvent('esx_grua_kahoo:resetTimer', v.plate)
            found = true
            break
        end
        ::continue::
    end

    if not found and limite then
        ESX.ShowNotification("Tu vehículo con matrícula [~r~"..v.plate.."~s~] ha desaparecido. Puedes reclamarlo en [~o~vehículos incautados~s~] en cualquier garaje")
        TriggerServerEvent('esx_grua_kahoo:setImpound', v.plate)
    elseif not found then
        ESX.ShowNotification("Tu vehículo con matrícula [~r~"..v.plate.."~s~] está cerca de incautarse por inactividad. Guárdalo antes de que ocurra.")
    end
end)


RegisterNetEvent('esx_grua_kahoo:antidupe')
AddEventHandler('esx_grua_kahoo:antidupe', function (v)
    local plate = v.plate.." "   -- IMPORTANTE (Sino no son ==)

    for vehicle in EnumerateVehicles() do
        if GetVehicleNumberPlateText(vehicle) ~= plate then
            goto continue      -- Salta al final del bucle
        end
        if IsVehiclePreviouslyOwnedByPlayer(vehicle) and GetVehicleNumberPlateText(vehicle) == plate then
            DeleteVehicle(vehicle)
        end
        ::continue::
    end
    
end)