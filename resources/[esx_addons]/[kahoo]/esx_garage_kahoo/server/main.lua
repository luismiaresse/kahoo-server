RegisterServerEvent('esx_garage:updateOwnedVehicle')
AddEventHandler('esx_garage:updateOwnedVehicle', function(stored, parking, Impound, vehicleProps)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

		MySQL.update('UPDATE owned_vehicles SET `stored` = @stored, `parking` = @parking, `pound` = @Impound, `vehicle` = @vehicle WHERE `plate` = @plate AND `owner` = @identifier',
		{
			['@identifier'] = xPlayer.identifier,
			['@vehicle'] 	= json.encode(vehicleProps),
			['@plate'] 		= vehicleProps.plate,
			['@stored']     = stored,
			['@parking']    = parking,
			['@Impound']    	= Impound
		})

		if stored then
			xPlayer.showNotification(_U('veh_stored'))
		end
end)

RegisterServerEvent('esx_garage:setImpound')
AddEventHandler('esx_garage:setImpound', function(Impound, vehicleProps)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

		MySQL.update('UPDATE owned_vehicles SET `stored` = @stored, `pound` = @Impound, `vehicle` = @vehicle WHERE `plate` = @plate AND `owner` = @identifier',
		{
			['@identifier'] = xPlayer.identifier,
			['@vehicle'] 	= json.encode(vehicleProps),
			['@plate'] 		= vehicleProps.plate,
			['@stored']     = 2,
			['@Impound']    	= Impound
		})

		xPlayer.showNotification(_U('veh_impounded'))
	
end)


local function GetVehiclesByState(xPlayer, vehState)
	-- Estados posibles: 0 = fuera del garaje, 1 = en el garaje, 2 = en el depósito
	local query = nil
	if xPlayer == nil then
		print("xPlayer nulo")
		return
	end

	-- Comprueba que el estado sea correcto
	if vehState == nil or (vehState ~= 0 and vehState ~= 1 and vehState ~= 2) then
		print("vehState nulo o incorrecto")
		return
	end

	-- Selecciona la consulta a realizar
	if vehState == 0 then
		query = 'SELECT * FROM `owned_vehicles` WHERE `owner` = @identifier AND `stored` = 0'
	elseif vehState == 1 then
		query = 'SELECT * FROM `owned_vehicles` WHERE `owner` = @identifier AND `stored` = 1'
	elseif vehState == 2 then
		query = 'SELECT * FROM `owned_vehicles` WHERE `owner` = @identifier AND `stored` = 2'
	end
	
	local vehicles = {}
	-- Consulta a la base de datos
	local result = MySQL.query.await(query, { ['@identifier'] = xPlayer.identifier })
	assert(result, "Error al obtener los vehículos del jugador")
	for i = 1, #result, 1 do
		table.insert(vehicles, {
			model 		= json.decode(result[i].vehicle).model,
			vehicle 	= json.decode(result[i].vehicle),
			plate 		= result[i].plate
		})
	end
	-- print("Vehículos devueltos: " .. #vehicles)
	return vehicles
end


ESX.RegisterServerCallback('esx_garage:getOwnedVehicles', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)
	cb(GetVehiclesByState(xPlayer, 0), GetVehiclesByState(xPlayer, 1), GetVehiclesByState(xPlayer, 2))
end)

ESX.RegisterServerCallback('esx_garage:checkVehicleOwner', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.query('SELECT COUNT(*) as count FROM `owned_vehicles` WHERE `owner` = @identifier AND `plate` = @plate',
	{
		['@identifier'] 	= xPlayer.identifier,
		['@plate']     		= plate
	}, function(result)

		if tonumber(result[1].count) > 0 then
			return cb(true)
		else
			return cb(false)
		end
	end)
end)

-- Pounds part
ESX.RegisterServerCallback('esx_garage:getVehiclesImpounded', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)

	MySQL.query('SELECT * FROM `owned_vehicles` WHERE `owner` = @identifier AND `stored` = 0',
	{
		['@identifier'] 	= xPlayer.identifier,
	}, function(result)
		local vehicles = {}
		
		for i = 1, #result, 1 do
			table.insert(vehicles, {
				vehicle 	= json.decode(result[i].vehicle),
				plate 		= result[i].plate
			})
		end

		cb(vehicles)
	end)
end)

ESX.RegisterServerCallback('esx_garage:getVehiclesInPound', function(source, cb, Impound)
	local xPlayer  = ESX.GetPlayerFromId(source)

	MySQL.query('SELECT * FROM `owned_vehicles` WHERE `owner` = @identifier AND `pound` = @Impound AND `stored` = 2',
	{
		['@identifier'] 	= xPlayer.identifier,
		['@Impound']     	    = Impound
	}, function(result)
		local vehicles = {}

		for i = 1, #result, 1 do
			table.insert(vehicles, {
				vehicle 	= json.decode(result[i].vehicle),
				plate 		= result[i].plate
			})
		end

		cb(vehicles)
	end)
end)

ESX.RegisterServerCallback('esx_garage:checkMoney', function(source, cb, amount)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(xPlayer.getMoney() >= amount)
end)

RegisterServerEvent("esx_garage:payPound")
AddEventHandler("esx_garage:payPound", function(amount)
		local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= amount then
        xPlayer.removeMoney(amount)
				xPlayer.showNotification(_U('pay_Impound_bill', amount))
    else
		xPlayer.showNotification(_U('missing_money'))
    end
end)


