-- Estados posibles
OUT = 0
STORED = 1
IMPOUND = 2


RegisterServerEvent('esx_garage:updateOwnedVehicle')
AddEventHandler('esx_garage:updateOwnedVehicle', function(stored, parking, vehicleProps)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	MySQL.update('UPDATE owned_vehicles SET `stored` = @stored, `parking` = @parking, `pound` = @Impound, `vehicle` = @vehicle WHERE `plate` = @plate AND `owner` = @identifier',
	{
		['@identifier'] = xPlayer.identifier,
		['@vehicle'] 	= json.encode(vehicleProps),
		['@plate'] 		= vehicleProps.plate,
		['@stored']     = stored,
		['@parking']    = parking
	})
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
			['@Impound']    = Impound
		})

		xPlayer.showNotification(_U('veh_impounded'))
	
end)


local function GetVehiclesByState(xPlayer, vehState)
	-- Estados posibles definidos al principio del archivo
	if xPlayer == nil then
		print("xPlayer nulo")
		return
	end
	
	-- Comprueba que el estado sea correcto
	if vehState == nil or (vehState ~= OUT and vehState ~= STORED and vehState ~= IMPOUND) then
		print("vehState nulo o incorrecto")
		return
	end
	
	local query = 'SELECT * FROM `owned_vehicles` WHERE `owner` = @identifier AND `stored` = '..vehState
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

ESX.RegisterServerCallback('esx_garage:checkMoney', function(source, cb, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(xPlayer.getMoney() >= amount)
end)

ESX.RegisterServerCallback('esx_garage:payFee', function(source, cb, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= amount then
		xPlayer.removeMoney(amount)
		cb(true)
	else
		cb(false)
	end
end)


