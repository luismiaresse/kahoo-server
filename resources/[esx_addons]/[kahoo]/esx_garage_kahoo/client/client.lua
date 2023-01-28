-- Estados posibles
OUT = 0
STORED = 1
IMPOUND = 2

local currentMarker, lastMarker = nil, nil
local isInMarker, isInVehicle, wasInMarker = false, false, false
local menuIsShowed = false

local function closeAllMenus()
    menuIsShowed = false
    ESX.UI.Menu.CloseAll()
end

AddEventHandler('esx_garage_kahoo:spawnVehicle', function(model, vehicleProps)
    local v = Config.Garages[currentMarker]
    local spawnPoint = v.SpawnPoint
    if ESX.Game.IsSpawnPointClear(spawnPoint, 2.5) then
        ESX.Game.SpawnVehicle(model, spawnPoint, spawnPoint.w, function(vehicle)
            TaskWarpPedIntoVehicle(ESX.PlayerData.ped, vehicle, -1)
            ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
            SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), true, true)
            if Config.RepairOnSpawn then
                CreateThread(function()
                    Wait(100)
                    SetVehicleFixed(vehicle)
                    SetVehicleDeformationFixed(vehicle)
                    SetVehicleUndriveable(vehicle, false)
                end)
            end
        end)
        ESX.ShowNotification(_U('veh_released'))    
    else
        ESX.ShowNotification(_U('veh_block'), "error")
    end
end)


-- Create Blips
CreateThread(function()
    for _, v in pairs(Config.Garages) do
        local blip = AddBlipForCoord(v.EntryPoint)
        SetBlipSprite(blip, v.Sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, v.Scale)
        SetBlipColour(blip, v.Colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(_U('parking_blip_name'))
        EndTextCommandSetBlipName(blip)
    end
end)

-- Display markers
CreateThread(function()
    while true do
        local sleep = 750
        local playerPed = ESX.PlayerData.ped
        local coords = GetEntityCoords(playerPed)
        isInMarker  = false
        currentMarker = nil
        for k, v in pairs(Config.Garages) do
            -- Dentro de la distancia de dibujo
            if GetDistanceBetweenCoords(coords, v.EntryPoint) < Config.DrawDistance then
                DrawMarker(Config.Markers.EntryPoint.Type, v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z, 0.0, 0.0,
                    0.0, 0, 0.0, 0.0, Config.Markers.EntryPoint.Size.x, Config.Markers.EntryPoint.Size.y,
                    Config.Markers.EntryPoint.Size.z, Config.Markers.EntryPoint.Color.r,
                    Config.Markers.EntryPoint.Color.g, Config.Markers.EntryPoint.Color.b, 100, false, true, 2, false,
                    false, false, false)
                sleep = 0
                -- Dentro del marker
                if GetDistanceBetweenCoords(coords, v.EntryPoint) < Config.Markers.EntryPoint.Size.x + 0.5 then
                    isInMarker = true
                    currentMarker = k
                end
            end
        end

        -- Entra al marker sin haberlo estado antes
		if (isInMarker and not wasInMarker) or (isInMarker and lastMarker ~= currentMarker) then
			wasInMarker = true
			lastMarker                = currentMarker
			TriggerEvent('esx_garage_kahoo:hasEnteredMarker')
            CreateThread(function()
                while isInMarker do
                    if IsControlJustReleased(0, 38) then
                        if isInVehicle then
                            TriggerEvent('esx_garage_kahoo:storeVehicle')
                        elseif not menuIsShowed then
                            TriggerEvent('esx_garage_kahoo:openMenu')
                        end
                    end
                    Wait(0)
                end
            end)
        end
        -- Sale del marker
		if not isInMarker and wasInMarker then
			wasInMarker = false
			TriggerEvent('esx_garage_kahoo:hasExitedMarker')
		end

        Wait(sleep)
    end
end)


local function vehicleOptions(vehicleList)
    local options, optionsVehicles = {}, {}
    for i = 1, #vehicleList, 1 do
        local friendlyName = GetLabelText(GetDisplayNameFromVehicleModel(vehicleList[i].model))
        table.insert(optionsVehicles, vehicleList[i].vehicle)
        table.insert(options, friendlyName .. " - " .. vehicleList[i].plate)
    end
    return options, optionsVehicles
end


AddEventHandler('esx_garage_kahoo:storeVehicle', function ()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
    assert(vehicleProps ~= nil, 'Vehicle props cannot be nil')
    local modelName = GetDisplayNameFromVehicleModel(vehicleProps.model)

    ESX.TriggerServerCallback('esx_garage_kahoo:checkVehicleOwner', function(owner)
        if owner then
            ESX.Game.DeleteVehicle(vehicle)
            TriggerServerEvent('esx_garage_kahoo:updateOwnedVehicle', STORED, currentMarker,
                modelName, vehicleProps)
            ESX.ShowNotification(_U('veh_stored'))
        else
            ESX.ShowNotification(_U('not_owning_veh'), 'error')
        end
    end, vehicleProps.plate)
    isInVehicle = false
end)



local function PayMenu(vehicleProps, amount)
    -- Si no es una opción sin vehículos
    if vehicleProps ~= nil then
        local modelName = GetDisplayNameFromVehicleModel(vehicleProps.model)
        if amount == 0 then
            TriggerEvent('esx_garage_kahoo:spawnVehicle', vehicleProps.model, vehicleProps)
            TriggerServerEvent('esx_garage_kahoo:updateOwnedVehicle', OUT, currentMarker, modelName,
                vehicleProps)
            return
        end
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'esx_garage_pay_menu', {
            title = _U('retrieve_fee', amount),
            align = 'bottom-right',
            elements = {
                {label = _U('no'), value = 'no'},
                {label = _U('yes'), value = 'yes'}
            }
        }, function(data, menu)
            if data.current.value == 'yes' then
                ESX.TriggerServerCallback('esx_garage_kahoo:payFee', function (canPay)
                    if canPay then
                        ESX.ShowNotification(_U('paid_retrieve_fee', amount))
                        TriggerEvent('esx_garage_kahoo:spawnVehicle', vehicleProps.model, vehicleProps)
                        TriggerServerEvent('esx_garage_kahoo:updateOwnedVehicle', OUT, currentMarker, modelName,
                            vehicleProps)
                    else
                        ESX.ShowNotification(_U('missing_money'), 'error')

                    end
                end, amount)
                closeAllMenus()
            else
                menu.close()
            end
        end, function(data, menu)
            menu.close()
        end)
    else 
        closeAllMenus()
        ESX.ShowNotification(_U('no_veh_to_retrieve'))
        ESX.TextUI(_U('access_parking'))
    end

end


AddEventHandler('esx_garage_kahoo:openMenu', function ()
    ESX.HideUI()
    ESX.TriggerServerCallback('esx_garage_kahoo:getOwnedVehicles', function(vehNotParkedList, vehParkedList, vehImpoundedList)
        -- imprime los coches disponibles
        -- print("vehParkedList: " .. json.encode(vehParkedList))
        -- print("vehNotParkedList: " .. json.encode(vehNotParkedList))
        -- print("vehImpoundedList: " .. json.encode(vehImpoundedList))
        local notParkedOptions, notParkedVehicles = vehicleOptions(vehNotParkedList)
        local parkedOptions, parkedVehicles = vehicleOptions(vehParkedList)
        local impoundedOptions, impoundedVehicles = vehicleOptions(vehImpoundedList)
        local optionsVehicles = {
            ['notparked'] = notParkedVehicles,
            ['parked'] = parkedVehicles,
            ['impounded'] = impoundedVehicles
        }
        local elements, options = {}, {}
        local vehStates = {
            {
                label = _U('parked_menu'),
                name = 'parked'
            },
            {
                label = _U('notparked_menu'),
                name = 'notparked'
            },
            {
                label = _U('impounded_menu'),
                name = 'impounded'
            }
        }

        -- print("notParkedOptions: " .. json.encode(notParkedOptions))
        -- print("parkedOptions: " .. json.encode(parkedOptions))
        -- print("impoundedOptions: " .. json.encode(impoundedOptions))

        for i = 1, #vehStates, 1 do
            local entryType = 'slider'
            if i == 1 then
                options = parkedOptions
            elseif i == 2 then
                options = notParkedOptions
            elseif i == 3 then
                options = impoundedOptions
            end
            if #options == 0 then
                entryType = 'label'
            end
            table.insert(elements, {
                name    = vehStates[i].name,
                label   = vehStates[i].label,
                value   = 0,   -- posición del slider
                type    = entryType,
                options = options
            })
        end
        
        -- print(json.encode(elements))
        
        menuIsShowed = true
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'esx_garage', {
            title = _U('parking_blip_name'),
            align = "bottom-right",
            elements = elements
        }, function(data, menu)   -- OnSelect function
            -- print("optionsVehicles: "..GetDisplayNameFromVehicleModel(optionsVehicles[data.current.name][data.current.value + 1].model))
            -- print("data:" .. json.encode(data))
            -- print("data.current.name: " .. data.current.name)
            -- print("data.current.value: " .. data.current.value)
            local amountToPay = 0
            if data.current.name == 'impounded' then
                amountToPay = Config.ImpoundPrice
            elseif data.current.name == 'notparked' then
                amountToPay = Config.OutPrice
            end
            local vehicleProps = optionsVehicles[data.current.name][data.current.value + 1]
            PayMenu(vehicleProps, amountToPay)
        end, function(data, menu) -- OnCancel function
            closeAllMenus()
            ESX.TextUI(_U('access_parking'))
        end)
    end)
end)


AddEventHandler('esx_garage_kahoo:hasEnteredMarker', function()
    isInVehicle = IsPedInAnyVehicle(ESX.PlayerData.ped, false)
    if isInVehicle then
        ESX.TextUI(_U('park_veh'))
    else
        ESX.TextUI(_U('access_parking'))
    end
end)

AddEventHandler('esx_garage_kahoo:hasExitedMarker', function()
    ESX.HideUI()
    if menuIsShowed then
        closeAllMenus()
    end
end)


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() and (menuIsShowed or isInMarker) then
        TriggerEvent('esx_garage_kahoo:hasExitedMarker')
    end
end)