
exports('getSharedObject', function()
	return ESX
end)

AddEventHandler('esx:getSharedObject', function(cb)
	cb(ESX)
end)

if GetResourceState('ox_inventory') ~= 'missing' then
	Config.OxInventory = true
end
