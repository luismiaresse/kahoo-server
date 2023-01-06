local grupo = nil
local invisible = false
local noclip = false
local godmode = false
local thermal = false
local nightvision = false
local superJump = false
local fastSprint = false
local onlinePlayers, forceDraw = {}, false
local currentAdminPlayers = {}
local visibleAdmins = {}


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    ESX.TriggerServerCallback('Roda-Tag:getAdminsPlayers', function(admins)
        currentAdminPlayers = admins
    end)
end)

RegisterKeyMapping("openrodaadminmenu", "Open Roda Menu", "keyboard", Config.KeyToOpen)

RegisterCommand("openrodaadminmenu", function(source,args)
	ESX.TriggerServerCallback('admin:grupo', function(group)  grupo = group end)
	while grupo == nil do
		Citizen.Wait(500)
	end

	for k,v in pairs(Configuracion.Grupos) do 
		if grupo == v then 
			ESX.UI.Menu.CloseAll()
			OpenPrincipalMenu()
		end
	end

	if grupo == 'user' then 
		ESX.UI.Menu.CloseAll()
		RockstarEditor()
	end

end)





function Text(text)
	SetTextColour(255, 255, 255, 255)
	SetTextFont(0)
	SetTextScale(0.478, 0.378)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry('STRING')
	AddTextComponentString(text)
	DrawText(0.007, 0.077)
end


local nombrelabel = nil
local usando = true 
function OpenMenuAdministrasion(source)
	local nombre = GetPlayerName(PlayerId())
    ESX.UI.Menu.CloseAll()
	local elements = {}

	--##This is for special perms, you can make more in the config##--
	--##SIMPLE GUIDE##--
			-- for k,v in pairs(Config.Perms['ped']) do
			-- 	if ESX.GetPlayerData().identifier == v then 
			-- 		table.insert(elements, {label = 'Ped 🐶',    value = 'ped_model'})
			-- 		table.insert(elements, {label = 'Borrar Ped 🐶',    value = 'player_ped'})
			-- 	end
			-- end

			-- for k,v in pairs(Config.Perms['godmode']) do
			-- 	if ESX.GetPlayerData().identifier == v then 
			-- 		table.insert(elements, {label = Config.Language["godmode"],    value = '1'})
			-- 	end
			-- end

	--##This is for special perms, you can make more in the config##--	
			table.insert(elements, {label = Config.Language["godmode"],    value = '1'})
			table.insert(elements, {label = 'Ped 🐶',    value = 'ped_model'})
			table.insert(elements, {label = 'Delete Ped 🐶',    value = 'player_ped'})
			table.insert(elements, {label = Config.Language["noclip"], value = '51'})
			table.insert(elements, {label = Config.Language["shownames"], value = 'show_names'})
			table.insert(elements, {label = Config.Language["tag"], value = 'admin_tag'})
			table.insert(elements, {label = Config.Language["invisible"],    value = '2'})
			table.insert(elements, {label = Config.Language["tpm"],    value = '3'}) 
			table.insert(elements, {label = Config.Language["jump"], value = 'jump'}) 
			table.insert(elements, {label = Config.Language["fastspeed"], value = 'fastspeed'})
			table.insert(elements, {label = Config.Language["copycoords"],    value = '4'})
			table.insert(elements, {label = Config.Language["opencar"],    value = '5'})
			table.insert(elements, {label = Config.Language["repair"],    value = '6'})
			table.insert(elements, {label = Config.Language["staffclothes"], value = 'staff_clothes'})
			table.insert(elements, {label = Config.Language["civilclothes"], value = 'civil_clothes'})
			
			
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_actions', {
				title    = 'STAFF | '..nombre..'',
				align    = 'bottom-left',
				elements = elements
			}, function(data, menu)
			
		if data.current.value == '1' then
			TriggerEvent("Roda-Admin:godmode", src) 
			menu.close()
		elseif data.current.value == '2' then
            TriggerEvent("Roda-Admin:invisible", src)
            menu.close()
		elseif data.current.value == 'show_names' then 
			mostrarnombre()
			menu.close()
		elseif data.current.value == 'admin_tag' then 
			usando = not usando 

			if usando then 
				if Config.Mythic then
					exports['mythic_notify']:DoLongHudText('inform', Config.Language["offtag"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
				else
					ESX.ShowNotification(Config.Language["offtag"])	
				end
				TriggerServerEvent('Roda-Admin:tag', GetPlayerServerId(PlayerId()))
				TriggerServerEvent('Roda-Admin:SendDiscordLogs','adminlogs', 'Admin Tag Off', 'red', 'The admin **'..GetPlayerName(PlayerId())..'** desactivate Admin Tag' , false) 

			elseif not usando then
				if Config.Mythic then
					exports['mythic_notify']:DoLongHudText('inform', Config.Language["activartag"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
				else
					ESX.ShowNotification(Config.Language["activartag"])	
				end
					TriggerServerEvent('Roda-Admin:tag', GetPlayerServerId(PlayerId()))
					TriggerServerEvent('Roda-Admin:SendDiscordLogs','adminlogs', 'Admin Tag ON', 'red', 'The admin **'..GetPlayerName(PlayerId())..'** use Admin Tag' , false) 
			end
		elseif data.current.value == 'jump' then 
			TriggerEvent("Roda-Admin:SuperJump", src)
			menu.close()
		elseif data.current.value == '51' then
            admin_no_clip()
            menu.close()
		elseif data.current.value == 'fastspeed' then
			RodaSpeed()
			menu.close()
        elseif data.current.value == '3' then
            TriggerEvent("Roda-Admin:teleport", src)
            menu.close()
		elseif data.current.value == 'ped_model' then 
			ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), 'ped_menu', {
				title = 'Ped Menu',
			}, function(menuData, menuHandle)
				local pedModel = menuData.value
							
				if not type(pedModel) == "number" then pedModel = 'pedModel' end
				if IsModelInCdimage(pedModel) then
					while not HasModelLoaded(pedModel) do
						Citizen.Wait(15)
						RequestModel(pedModel)
					end
					SetPlayerModel(PlayerId(), pedModel)
					menuHandle.close()
				else
					if Config.Mythic then
						exports['mythic_notify']:DoLongHudText('inform', Config.Language["nomodel"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
					else
						ESX.ShowNotification(Config.Language["nomodel"])	
					end
				end
			end, function(menuData, menuHandle)
				menuHandle.close()
			end)
			TriggerEvent('esx:restoreLoadout')
		elseif data.current.value == 'player_ped' then 
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				local model = nil
			
				if skin.sex == 0 then
				  model = GetHashKey("mp_m_freemode_01")
				else
				  model = GetHashKey("mp_f_freemode_01")
				end
			
				RequestModel(model)
				while not HasModelLoaded(model) do
				  RequestModel(model)
				  Citizen.Wait(1)
				end
			
				SetPlayerModel(PlayerId(), model)
				SetModelAsNoLongerNeeded(model)
			
				TriggerEvent('skinchanger:loadSkin', skin)
				TriggerEvent('esx:restoreLoadout')
				end)
        elseif data.current.value == '4' then
			TriggerEvent('Roda-Admin:coords')
            menu.close()
        elseif data.current.value == '5' then
            TriggerEvent("Roda-Admin:abrircoche", src)
			if Config.Mythic then 
				exports['mythic_notify']:DoLongHudText('inform', Config.Language["caropen"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
			else
				ESX.ShowNotification(Config.Language["caropen"])	
			end
            menu.close()
        elseif data.current.value == '6' then
            TriggerEvent("Roda-Admin:fixcar", src)
            menu.close()
		elseif data.current.value == 'staff_clothes' then 
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, Config.StaffClothes.male)
				elseif skin.sex == 1 then
					TriggerEvent('skinchanger:loadClothes', skin, Config.StaffClothes.female)
				end
			end)
			if Config.Mythic then 
				exports['mythic_notify']:DoLongHudText('inform', Config.Language["clothesstaff"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
			else
				ESX.ShowNotification(Config.Language["clothesstaff"])
				
			end
		elseif data.current.value == 'civil_clothes' then 
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
			
			if Config.Mythic then 
				exports['mythic_notify']:DoLongHudText('inform', Config.Language["clothescivil"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
			else
				ESX.ShowNotification(Config.Language["clothescivil"])
				
			end

			menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end

function OpenPlayerOption(source)
    ESX.UI.Menu.CloseAll()
	ESX.TriggerServerCallback('Roda-Admin:playersonline', function(players)
		local elements = {}
		for i=1, #players, 1 do
				table.insert(elements, {
					label = players[i].name .. ' | ' .. players[i].source .. ' | ' .. players[i].group,
					value = players[i].source,
					name = players[i].name
				})
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_list', {
			title    = Config.Language["listplayers"]..#players..' / '..Config.ServerPlayers..'',
			align    = 'bottom-left',
			elements = elements
		}, function(data2, menu2)

			local elementos = {}
			--EXAMPLE OF ESPECIAL PERMS.
			-- for k,v in pairs(Config.Perms['dock']) do
			-- 	if ESX.GetPlayerData().identifier == v then 
			-- 		table.insert(elementos, {label = Config.Language["dock"], value = 'ckplayer'})
			-- 	end
			-- end
			table.insert(elementos, {label = Config.Language["openclothes"], value = 'openclothes'})
			table.insert(elementos, {label = Config.Language["tpmap"], value = 'tpmap'})
			table.insert(elementos, {label = Config.Language["kick"], value = 'kick'})
			table.insert(elementos, {label = Config.Language["gotop"], value = 'goto'})
			table.insert(elementos, {label = Config.Language["bring"], value = 'bring'})
			table.insert(elementos, {label = Config.Language["ban"], value = 'ban_player'})
			table.insert(elementos, {label = Config.Language["changename"], value = 'changename'})
			table.insert(elementos, {label = Config.Language["dock"], value = 'ckplayer'})
			table.insert(elementos, {label = Config.Language["givemoney"], value = 'givemoney'})
			table.insert(elementos, {label = Config.Language["givecar"], value = 'givecar'})
			table.insert(elementos, {label = Config.Language["giveweapon"], value = 'giveweapon'})
			table.insert(elementos, {label = Config.Language["revplayer"], value = 'revive_player'})
			table.insert(elementos, {label = Config.Language["setjob"], value = 'set_job'}) 
			table.insert(elementos, {label = Config.Language["cartogarage"], value = 'car_garage'})
			table.insert(elementos, {label = Config.Language["inventory"], value = 'check_inventory'})
			table.insert(elementos, {label = Config.Language["sendidentifiers"], value = 'send_identifier'})
			table.insert(elementos, {label = Config.Language["seeall"], value = 'see_ident'})
			table.insert(elementos, {label = Config.Language["see_cars"], value = 'see_cars'})
			if Config.TakeScreenshot then 
				table.insert(elementos, {label = Config.Language["photo"], value = 'take_photo'})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_name', {
				title    = 'ID: '..data2.current.value..'',
				align    = 'bottom-left',
				elements = elementos
			}, function(data3, menu3)
				menu3.close()
				local name = data2.current.name
				local Playerid = data2.current.value
				
				if data3.current.value == 'kick' then

					ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), 'kick_player', {
						title = Config.Language["reason"],
					}, function(menuData, menuHandle)
						local Reason = menuData.value
									
						if Reason == nil then
							if Config.Mythic then 
								exports['mythic_notify']:DoLongHudText('inform', Config.Language["insertreason"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
							else
								ESX.ShowNotification(Config.Language["insertreason"])								
							end
						else
							TriggerServerEvent('Roda-Admin:kickPlayer', Playerid, Reason)
							menuHandle.close()
						end
					end, function(menuData, menuHandle)
						menuHandle.close()
					end)
				elseif data3.current.value == 'tpmap' then 
						local kaka = 'PingaLocaOlaHuanaticoO'
						TriggerServerEvent('Roda-Admin:tpToWayPoint', Playerid, kaka)
				elseif data3.current.value == 'goto' then 
					TriggerServerEvent('Roda-Admin:goto', Playerid)
				elseif data3.current.value == 'openclothes' then 
					TriggerServerEvent('Roda-Admin:OpenClothes', Playerid)
				elseif data3.current.value == 'bring' then 
					TriggerServerEvent('Roda-Admin:bring', Playerid)
				elseif data3.current.value == 'giveweapon' then 
					local weapons = ESX.GetWeaponList()
					ESX.UI.Menu.CloseAll()
					local elements = {}
							for k,v in pairs(weapons) do 
					  		table.insert(elements, {label = v.label,    value = v.name , tipo = 'arma'})
							end
							
							
							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_actions', {
								title    = 'ID |'..Playerid..'',
								align    = 'bottom-left',
								elements = elements
							}, function(data, menu)
							
				
						    if data.current.tipo == 'arma' then
							TriggerServerEvent('Roda-Admin:GiveWeapon', Playerid,  data.current.value, 10)
							menu.close()
							end
					end, function(data, menu)
						menu.close()
					end)
				elseif data3.current.value == 'see_cars' then 
					TriggerServerEvent('Roda-Admin:GetPlayerCars', Playerid)
				elseif data3.current.value == 'changename' then
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'changename', {
								title = Config.Language["newname"]
								}, function(data, menu)
									ESX.UI.Menu.CloseAll()
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'change_name', {
										title = Config.Language["newlastname"]
										}, function(data3, menu3)
			
										local name = data.value
										local lastname = data3.value
										if lastname == nil then
											if Config.Mythic then 
												exports['mythic_notify']:DoLongHudText('inform', Config.Language["nomount"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
											else
												ESX.ShowNotification(Config.Language["nolast"])
												
											end
										else
											menu.close()
											ESX.UI.Menu.CloseAll()
											TriggerServerEvent('Roda-Admin:changenameMenu',Playerid, name, lastname)
											if Config.Mythic then 
												exports['mythic_notify']:DoLongHudText('inform', Config.Language["nuevonombre"]..name.. ' '..lastname..'', { ['background-color'] = '#000000', ['color'] = '#f00000' })
											else
												ESX.ShowNotification(Config.Language["nuevonombre"]..name.. ' '..lastname..'')
												
											end
										end
								end, function(data3, menu3)
									menu3.close()
								end)
							end, function(data, menu)
								menu.close()
						end)

			elseif data3.current.value == 'givemoney' then

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'money', {
					title = Config.Language["insertaccount"]
					}, function(data, menu)
						ESX.UI.Menu.CloseAll()
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'money_give', {
							title = Config.Language["insertmount"]
							}, function(data3, menu3)

							local account = data.value
							local amount = tonumber(data3.value)
							if amount == nil then
								if Config.Mythic then 
									exports['mythic_notify']:DoLongHudText('inform', Config.Language["nomount"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
								else
									ESX.ShowNotification(Config.Language["nomount"])
									
								end
							else
								menu.close()
								ESX.UI.Menu.CloseAll()
								TriggerServerEvent('Roda-Admin:GiveMoney',Playerid, account, amount)
							end
					end, function(data3, menu3)
						menu3.close()
					end)
				end, function(data, menu)
					menu.close()
				end)

				
				elseif data3.current.value == 'revive_player' then
					TriggerServerEvent('Roda-Admin:revivePlayer', Playerid)
				elseif data3.current.value == 'givecar' then
					ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), 'car_menu', {
						title = 'Insert Car',
					}, function(menuData, menuHandle)
						local carModel = menuData.value	
						if IsModelInCdimage(carModel) then 		
						ExecuteCommand('givecar '..Playerid..' '..carModel..'')
						if Config.Mythic then 
							exports['mythic_notify']:DoLongHudText('inform', Config.Language["spawncar"]..carModel, { ['background-color'] = '#000000', ['color'] = '#f00000' })
						else
							ESX.ShowNotification(Config.Language["spawncar"]..carModel)	
						end
						menuHandle.close()
						else 
							if Config.Mythic then 
								exports['mythic_notify']:DoLongHudText('inform', Config.Language["nomodel"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
							else
								ESX.ShowNotification(Config.Language["nomodel"])	
							end
						end
					end, function(menuData, menuHandle)
						menuHandle.close()
					end)

				elseif data3.current.value == 'see_ident' then 
					local Playerid = data2.current.value
					TriggerServerEvent('Roda-Admin:IdentifiersPe', data2.current.value)
					ESX.UI.Menu.CloseAll()
				elseif data3.current.value == 'ban_player' then 
					local Playerid = data2.current.value
					banMenu(Playerid)
					
				elseif data3.current.value == 'car_garage' then
							if IsPedSittingInAnyVehicle(PlayerPedId()) then 
								local ped = PlayerPedId()
								local vehicle = GetVehiclePedIsIn(ped, false)
								local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
								GenerateRandomPlate()
								vehicleProps.plate = generatedPlate
								local Modelo = GetDisplayNameFromVehicleModel(vehicleProps.model) 
								SetVehicleNumberPlateText(vehicle, vehicleProps.plate)
								TriggerServerEvent('Roda-Admin:CarToGarage', Playerid, vehicleProps, Modelo)
							else
								if Config.Mythic then 
									exports['mythic_notify']:DoLongHudText('inform', Config.Language["subete"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
								else
									ESX.ShowNotification(Config.Language["subete"])	
								end
							end
				elseif data3.current.value == 'check_inventory' then

					if Config.CustomTrigger then 
						TriggerEvent(Config.TriggerForSearch, Playerid)
					else
						TriggerEvent('esx_inventoryhud:openPlayerInventory', Playerid, PlayerId(), GetPlayerName(Playerid))
					end

				elseif data3.current.value == 'take_photo' then
					TriggerServerEvent('Roda-Admin:TakePhoto', Playerid)
				elseif data3.current.value == 'send_identifier' then
					TriggerServerEvent('Roda-Admin:Send_Identifier', Playerid)
				elseif data3.current.value == 'set_job' then

					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'job_give', {
						title = Config.Language["job"]
						}, function(data, menu)
							ESX.UI.Menu.CloseAll()
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'jobgrade_give', {
								title = Config.Language["jobgrade"]
								}, function(data3, menu3)
	
								local job = data.value
								local grade = tonumber(data3.value)
								if grade == nil then
									if Config.Mythic then 
										exports['mythic_notify']:DoLongHudText('inform', Config.Language["nonull"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
									else
										ESX.ShowNotification(Config.Language["nonull"])	
									end
								elseif grade == 0 then 
									menu.close()
									ESX.UI.Menu.CloseAll()
									TriggerServerEvent('Roda-Admin:set_job', Playerid, job, grade)
								else
									menu.close()
									ESX.UI.Menu.CloseAll()
									TriggerServerEvent('Roda-Admin:set_job', Playerid, job, grade)
								end
						end, function(data3, menu3)
							menu3.close()
						end)
					end, function(data, menu)
						menu.close()
					end)

				elseif data3.current.value == 'ckplayer' then

					

					ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), 'ck_player', {
						title = Config.Language["yesorno"],
					}, function(menuData, menuHandle)
						local Reason = menuData.value
									
						if Reason == 'si' or Reason == 'yes' or Reason == 'YES' or Reason == 'SI' or Reason == 'Si' or Reason == 'Yes' then

							if Config.Mythic then 
								exports['mythic_notify']:DoLongHudText('inform', Config.Language["yesck"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
							else
								ESX.ShowNotification(Config.Language["yesck"])
								
							end

							TriggerServerEvent('Roda-Admin:ckplayer', Playerid, name)
							menuHandle.close()
						elseif Reason ~= 'si' or Reason ~= 'yes' then 
						
							if Config.Mythic then 
								exports['mythic_notify']:DoLongHudText('inform', Config.Language["confirmck"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
							else
								ESX.ShowNotification(Config.Language["confirmck"])
								
							end
						elseif Reason == nil then 

							if Config.Mythic then 
								exports['mythic_notify']:DoLongHudText('inform', Config.Language["nock"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
							else
								ESX.ShowNotification(Config.Language["nock"])
								
							end							

						end
					end, function(menuData, menuHandle)
						menuHandle.close()
					end)

				end
			end, function(data3, menu3)
				menu3.close()
			end)

		end, function(data2, menu2)
			menu2.close()
		end)

	end)
   
end

function OpenServerOptions(source)
	local nombre = GetPlayerName(PlayerId())
    ESX.UI.Menu.CloseAll()
	local elements = {}

	table.insert(elements,{label = Config.Language["deleteveh"], value = 'delete_cars'})
	table.insert(elements,{label = Config.Language["deleteobj"], value = 'del_obj'})
	table.insert(elements,{label = Config.Language["deleteped"], value = 'del_ped'})
	table.insert(elements,{label = Config.Language["clearchat"], value = 'del_chat'})
	table.insert(elements,{label = Config.Language["makeannounce"],  value = 'admin_announce'})
	table.insert(elements,{label = Config.Language["reviveall"],    value = 'revive_all'})
	table.insert(elements, {label = 'Unban', value = 'unbanmenu'})
	table.insert(elements,{label = 'Bring All',    value = 'bringall'})

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_actions',
    {
        title    = 'STAFF | '..nombre..'',
        align    = 'bottom-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'delete_cars' then
            TriggerServerEvent('Roda-Admin:delallveh')
			if Config.Mythic then 
				exports['mythic_notify']:DoLongHudText('inform', Config.Language["delallveh"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
			else
				ESX.ShowNotification(Config.Language["delallveh"])
				
			end
            menu.close()
       	elseif data.current.value == 'del_obj' then
            TriggerServerEvent('Roda-Admin:delallobj')
			if Config.Mythic then 
				exports['mythic_notify']:DoLongHudText('inform', Config.Language["delallobj"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
			else
				ESX.ShowNotification(Config.Language["delallobj"])
				
			end
            menu.close()
        elseif data.current.value == 'unbanmenu' then 
			unbanMenu()
        elseif data.current.value == 'del_ped' then
            TriggerServerEvent('Roda-Admin:delallped')
			if Config.Mythic then 
				exports['mythic_notify']:DoLongHudText('inform', Config.Language["delallpeds"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
			else
				ESX.ShowNotification(Config.Language["delallpeds"])
				
			end
            menu.close()

        elseif data.current.value == 'del_chat' then
			TriggerServerEvent('Roda-Admin:clearchat')
			if Config.Mythic then 
				exports['mythic_notify']:DoLongHudText('inform', Config.Language["delallchat"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
			else
				ESX.ShowNotification(Config.Language["delallchat"])
				
			end
            menu.close()

        elseif data.current.value == 'admin_announce' then

			ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), 'announce', {
				title = Config.Language["insertannounce"],
			}, function(menuData, menuHandle)
				local Reason = menuData.value
							
				if Reason == nil then
					if Config.Mythic then 
						exports['mythic_notify']:DoLongHudText('inform', Config.Language["noannounce"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
					else
						ESX.ShowNotification(Config.Language["noannounce"])
						
					end
				else
					TriggerServerEvent('Roda-Admin:AnnounceServer', Reason)
					menuHandle.close()
				end
			end, function(menuData, menuHandle)
				menuHandle.close()
			end)
            menu.close()
		elseif data.current.value == 'bringall' then 
			TriggerServerEvent('Roda-Admin:todospami')
		elseif data.current.value == 'revive_all' then
			menu.close()

			ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), 'revive_all', {
				title = Config.Language["yesorno"],
			}, function(menuData, menuHandle)
				local Reason = menuData.value
							
				if Reason == 'si' or Reason == 'yes' or Reason == 'YES' or Reason == 'SI' or Reason == 'Si' or Reason == 'Yes' then

					if Config.Mythic then 
						exports['mythic_notify']:DoLongHudText('inform', Config.Language["yesrev"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
					else
						ESX.ShowNotification(Config.Language["yesrev"])
						
					end
					TriggerServerEvent('Ra-Admin:reviveall')
					menuHandle.close()
				elseif Reason ~= 'si' or Reason ~= 'yes' then 
				
					if Config.Mythic then 
						exports['mythic_notify']:DoLongHudText('inform', Config.Language["confrev"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
					else
						ESX.ShowNotification(Config.Language["confrev"])
						
					end
				elseif Reason == nil then 

					if Config.Mythic then 
						exports['mythic_notify']:DoLongHudText('inform', Config.Language["norev"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
					else
						ESX.ShowNotification(Config.Language["norev"])
						
					end							

				end
			end, function(menuData, menuHandle)
				menuHandle.close()
			end)
        end
    end, function(data, menu)
        menu.close()
    end)
end


function OpenPrincipalMenu(source)
	local nombre = GetPlayerName(PlayerId())

	ESX.UI.Menu.CloseAll()
	local elementos = {}

	table.insert(elementos, {label = Config.Language["personal"],    value = 'personal_options'})
	table.insert(elementos, {label = Config.Language["server"],    value = 'server_options'})
	table.insert(elementos, {label = Config.Language["players"],    value = 'player_options'})
	table.insert(elementos,	{label = Config.Language["vision"], value = 'visions'})

	table.insert(elementos, {label = Config.Language["rockstar"],    value = 'open_editor_rockstar'})

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'principal_menu', {
		title    = 'STAFF | '..nombre..'',
		align    = 'bottom-left',
		elements = elementos
	}, function(data, menu)
		
		if data.current.value == 'personal_options' then
            OpenMenuAdministrasion()
            menu.close()
       	elseif data.current.value == 'server_options' then
            OpenServerOptions()
            menu.close()
		elseif data.current.value == 'visions' then 
			OpenVisionMenu()
			menu.close()
		elseif data.current.value == 'player_options' then 
			OpenPlayerOption()
		elseif data.current.value == 'open_editor_rockstar' then 
			RockstarEditor()
        end
    end, function(data, menu)
        menu.close()
    end)
end

--SetNightvision

function thermalVision()
	thermal = not thermal
	if thermal then 
		SetSeethrough(true)
		if Config.Mythic then 
			exports['mythic_notify']:DoLongHudText('inform', Config.Language["onthermal"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
		else
			ESX.ShowNotification(Config.Language["onthermal"])
			
		end
		thermal = true
	else
		SetSeethrough(false)
		if Config.Mythic then 
			exports['mythic_notify']:DoLongHudText('inform', Config.Language["delthermal"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
		else
			ESX.ShowNotification(Config.Language["delthermal"])
			
		end
		thermal = false
	end
end

function NightVision()
	nightvision = not nightvision
	if nightvision then 
		SetNightvision(true)
		if Config.Mythic then 
			exports['mythic_notify']:DoLongHudText('inform', Config.Language["onvision"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
		else
			ESX.ShowNotification(Config.Language["onvision"])
			
		end
		nightvision = true
	else
		SetNightvision(false)
		if Config.Mythic then 
			exports['mythic_notify']:DoLongHudText('inform', Config.Language["offvision"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
		else
			ESX.ShowNotification(Config.Language["offvision"])
			
		end
		nightvision = false
	end
end


-- --Thermal Vision
-- RegisterNetEvent('Roda-Admin:ThermalVision')
-- AddEventHandler('Roda-Admin:ThermalVision',function()
-- 	if thermal then
-- 		SetSeethrough(true)

-- 		if Config.Mythic then 
-- 			exports['mythic_notify']:DoLongHudText('inform', Config.Language["delgod"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
-- 		else
-- 			ESX.ShowNotification(Config.Language["delgod"])
			
-- 		end
-- 		thermal = false
-- 	else
-- 		SetEntityInvincible(PlayerPedId(),true)

-- 		if Config.Mythic then 
-- 			exports['mythic_notify']:DoLongHudText('inform', Config.Language["activegod"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
-- 		else
-- 			ESX.ShowNotification(Config.Language["activegod"])
			
-- 		end
-- 		thermal = true
-- 	end
-- end)

--Godmode function

RegisterNetEvent('Roda-Admin:godmode')
AddEventHandler('Roda-Admin:godmode',function()
	if godmode then
		SetEntityInvincible(PlayerPedId(),false)

		if Config.Mythic then 
			exports['mythic_notify']:DoLongHudText('inform', Config.Language["delgod"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
		else
			ESX.ShowNotification(Config.Language["delgod"])
			
		end
		godmode = false
		TriggerServerEvent('Roda-Admin:SendDiscordLogs','adminlogs', 'God Mode Off', 'red', 'The admin **'..GetPlayerName(PlayerId())..'** desactivate GodMode' , false) 

	else
		SetEntityInvincible(PlayerPedId(),true)

		if Config.Mythic then 
			exports['mythic_notify']:DoLongHudText('inform', Config.Language["activegod"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
		else
			ESX.ShowNotification(Config.Language["activegod"])
			
		end
		godmode = true
		TriggerServerEvent('Roda-Admin:SendDiscordLogs','adminlogs', 'God Mode ON', 'red', 'The admin **'..GetPlayerName(PlayerId())..'** use GodMode' , false) 
	end
end)


--Invisible
RegisterNetEvent('Roda-Admin:invisible')
AddEventHandler('Roda-Admin:invisible',function()
	if invisible == false then
		SetEntityVisible(PlayerPedId(),false)
		invisible = true

		if Config.Mythic then 
			exports['mythic_notify']:DoLongHudText('inform', Config.Language["activeinvi"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
		else
			ESX.ShowNotification(Config.Language["activeinvi"])
			
		end
		TriggerServerEvent('Roda-Admin:SendDiscordLogs','adminlogs', 'Invisible ON', 'red', 'The admin '..GetPlayerName(PlayerId())..' use Invisible' , false) 
	else
		SetEntityVisible(PlayerPedId(),true)
		invisible = false

		if Config.Mythic then 
			exports['mythic_notify']:DoLongHudText('inform', Config.Language["delinvi"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
		else
			ESX.ShowNotification(Config.Language["delinvi"])
		end
		TriggerServerEvent('Roda-Admin:SendDiscordLogs','adminlogs', 'Invisible OFF', 'red', 'The admin '..GetPlayerName(PlayerId())..' desactivate Invisible' , false) 
	end
end)


RegisterNetEvent('Roda-Admin:teleport')
AddEventHandler('Roda-Admin:teleport',function()
local WaypointHandle = GetFirstBlipInfoId(8)

    if DoesBlipExist(WaypointHandle) then
		if Config.Mythic then 
			exports['mythic_notify']:DoLongHudText('inform', Config.Language["donetpm"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
		else
			ESX.ShowNotification(Config.Language["donetpm"]) 
		end

        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords.x, waypointCoords.y, height + 0.0)

            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y, height + 0.0)

            if foundGround then
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords.x, waypointCoords.y, height + 0.0)

                break
            end
            Citizen.Wait(10)
        end
    else
		if Config.Mythic then 
			exports['mythic_notify']:DoLongHudText('inform', Config.Language["nopoint"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
		else
			ESX.ShowNotification(Config.Language["nopoint"])
			
		end
    end
end)

--OpenCar

RegisterNetEvent('Roda-Admin:abrircoche')
AddEventHandler('Roda-Admin:abrircoche',function()
  local coords = GetEntityCoords(PlayerPedId())

  local vehicle, distance = ESX.Game.GetClosestVehicle({
    x = coords.x,
    y = coords.y,
    z = coords.z
  })
  	if distance ~= -1 and distance <= 2.0 then
		SetVehicleDoorsLocked(vehicle, 1)
		SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
	end
end)


RegisterNetEvent('Roda-getCarP')
AddEventHandler('Roda-getCarP',function(modelo, targetname)
	local nombre = targetname
	local props = modelo
    ESX.UI.Menu.CloseAll()
	local elements = {}
			for k,v in pairs(props) do 
				table.insert(elements, {label = "Plate: "..v.vehicle.plate.." | Car Name: "..GetDisplayNameFromVehicleModel(v.vehicle.model).."",    value = v.vehicle.plate ,tipo = "delcar"})
			end
				
		
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_actions', {
				title    = 'Cars Of | '..nombre..'',
				align    = 'bottom-left',
				elements = elements
			}, function(data, menu)
			

       	if data.current.tipo == 'delcar' then
            TriggerServerEvent('Roda-DelVehicle', data.current.value )
            menu.close()
	    end
    end, function(data, menu)
        menu.close()
    end)
end)

--RepairCar

RegisterNetEvent('Roda-Admin:fixcar')
AddEventHandler('Roda-Admin:fixcar',function()
	local coche = nil
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		 coche =  GetVehiclePedIsIn(PlayerPedId(),false)
	else 
		if Config.Mythic then 
			exports['mythic_notify']:DoLongHudText('inform', Config.Language["nosit"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
		else
			ESX.ShowNotification(Config.Language["nosit"])
			
		end
	end
	if coche then
	    SetVehicleFixed(coche)
	    SetVehicleDeformationFixed(coche)
		if Config.Mythic then 
			exports['mythic_notify']:DoLongHudText('inform', Config.Language["fixcar"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
		else
			ESX.ShowNotification(Config.Language["fixcar"])
			
		end
	end
end)

-- Afficher Nom


function getCamDirection()
	local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(plyPed)
	local pitch = GetGameplayCamRelativePitch()
	local coords = vector3(-math.sin(heading * math.pi / 180.0), math.cos(heading * math.pi / 180.0), math.sin(pitch * math.pi / 180.0))
	local len = math.sqrt((coords.x * coords.x) + (coords.y * coords.y) + (coords.z * coords.z))

	if len ~= 0 then
		coords = coords / len
	end

	return coords
end



function RodaSpeed()
  fastSprint = not fastSprint
  if fastSprint then
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
	if Config.Mythic then 
		exports['mythic_notify']:DoLongHudText('inform', Config.Language["fastrun"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
	else
		ESX.ShowNotification(Config.Language["fastrun"])		
	end
	TriggerServerEvent('Roda-Admin:SendDiscordLogs','adminlogs', 'SuperSpeed ON', 'red', 'The admin '..GetPlayerName(PlayerId())..' use SuperSpeed' , false)  --You can put true for @everyone.

  else
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
	if Config.Mythic then 
		exports['mythic_notify']:DoLongHudText('inform', Config.Language["nofastrun"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
	else
		ESX.ShowNotification(Config.Language["nofastrun"])		
	end
	TriggerServerEvent('Roda-Admin:SendDiscordLogs','adminlogs', 'SuperSpeed OFF', 'red', 'The admin '..GetPlayerName(PlayerId())..' desactivate SuperSpeed' , false)  --You can put true for @everyone.

  end

end

function admin_no_clip()
	noclip = not noclip
	if noclip then
		plyPed = PlayerPedId()
		FreezeEntityPosition(plyPed, true)
		SetEntityInvincible(plyPed, true)
		SetEntityCollision(plyPed, false, false)

		SetEntityVisible(plyPed, false, false)

		SetEveryoneIgnorePlayer(PlayerId(), true)
		SetPoliceIgnorePlayer(PlayerId(), true)

		if Config.Mythic then 
			exports['mythic_notify']:DoLongHudText('inform', Config.Language["actinoclip"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
		else
			ESX.ShowNotification(Config.Language["actinoclip"])		
		end
		TriggerServerEvent('Roda-Admin:SendDiscordLogs','adminlogs', 'Noclip ON', 'red', 'The admin '..GetPlayerName(PlayerId())..' use Noclip' , false)  --You can put true for @everyone.

	else
		plyPed = PlayerPedId()
		FreezeEntityPosition(plyPed, false)
		SetEntityInvincible(plyPed, false)
		SetEntityCollision(plyPed, true, true)

		SetEntityVisible(plyPed, true, false)


		if Config.Mythic then 
			exports['mythic_notify']:DoLongHudText('inform', Config.Language["delnoclip"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
		else
			ESX.ShowNotification(Config.Language["delnoclip"])
			
		end
		TriggerServerEvent('Roda-Admin:SendDiscordLogs','adminlogs', 'Noclip OFF', 'red', 'The admin '..GetPlayerName(PlayerId())..' desactivate Noclip' , false) 
	end
end


RegisterNetEvent('Roda-ShowId:client:add-id')
AddEventHandler('Roda-ShowId:client:add-id', function(identifier, playerSource)
    if playerSource then
        onlinePlayers[playerSource] = identifier
    else
        onlinePlayers = identifier
    end
end)

function Draw3DText(x, y, z, text, newScale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = newScale * (1 / dist) * (1 / GetGameplayCamFov()) * 100
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function GetNeareastPlayers()
    local playerPed = PlayerPedId()
    local players_clean = {}
    local playerCoords = GetEntityCoords(playerPed)
    if IsPedInAnyVehicle(playerPed, false) then
        local playersId = tostring(GetPlayerServerId(PlayerId()))
		local player = GetPlayerFromServerId(playersId)
		local ped = GetPlayerPed(player)
        table.insert(players_clean, {topText = onlinePlayers[playersId], playerId = playersId, coords = playerCoords, vida = GetEntityHealth(ped), chaleco = GetPedArmour(ped)} )
    else
        local players, _ = GetPlayersInArea(playerCoords, Configuracion.drawDistance)
        for i = 1, #players, 1 do
            local playerServerId = GetPlayerServerId(players[i])
            local player = GetPlayerFromServerId(playerServerId)
            local ped = GetPlayerPed(player)
            if IsEntityVisible(ped) then
                for x, identifier in pairs(onlinePlayers) do 
                    if x == tostring(playerServerId) then
                        table.insert(players_clean, {topText = identifier:upper(), playerId = playerServerId, vida = GetEntityHealth(ped), chaleco = GetPedArmour(ped), coords = GetEntityCoords(ped)})
                    end
                end
            end
        end
    end
   
    return players_clean
end

function GetPlayersInArea(coords, area)
	local players, playersInArea = GetPlayers(), {}
	local coords = vector3(coords.x, coords.y, coords.z)
	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])
		local targetCoords = GetEntityCoords(target)

		if #(coords - targetCoords) <= area then
			table.insert(playersInArea, players[i])
		end
	end
	return playersInArea
end

function GetPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end

Citizen.CreateThread(function()
	TriggerServerEvent("Roda-ShowId:add-id")
	while true do
		local sleep = 500
		plyPed = PlayerPedId()
		if noclip then
			sleep = 0
			local coords = GetEntityCoords(plyPed)
			local camCoords = getCamDirection()
			local velocidad = Config.SpeedNoClip

			SetEntityVelocity(plyPed, 0.01, 0.01, 0.01)

			if IsControlPressed(0, 32) then
				coords = coords + (velocidad * camCoords)
			end

			if IsControlPressed(0, 269) then
				coords = coords - (velocidad * camCoords)
			end

			SetEntityCoordsNoOffset(plyPed, coords, true, true, true)
		elseif superJump then
			sleep = 0
			SetSuperJumpThisFrame(PlayerId())
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
    TriggerServerEvent("Roda-ShowId:add-id")
    while true do
        local sleep = 500
        if forceDraw then
			sleep = 0
            for k, v in pairs(GetNeareastPlayers()) do
				local x, y, z = table.unpack(v.coords)
				local vidareal = tonumber(v.vida) - 100
                Draw3DText(x, y-0.4, z + 1.0, Config.Language["health"]..vidareal.." | "..Config.Language["chaleco"]..v.chaleco, 2.8) 
                Draw3DText(x, y, z + 1.50, '['..v.playerId..'] '..v.topText, 3.0)
            end
        end
		for k, v in pairs(visibleAdmins) do
			sleep = 0
            local playerServerID = GetPlayerFromServerId(v.source)
            if playerServerID ~= -1 then
                local adminPed = GetPlayerPed(playerServerID)
                local adminCoords = GetEntityCoords(adminPed)
                local x, y, z = table.unpack(adminCoords)
                z = z + 1.2
				
                local label
				label = Config.GroupLabels[v.group]
                if label then
                    if v.source == GetPlayerServerId(PlayerId()) then
                        if Config.verTag == true then
                            Draw3DText(x,y,z, label, 1.3)
                        end
                    else
                        Draw3DText(x,y,z, label, 1.3)
                    end
                end
            end
        end
		Citizen.Wait(sleep)
    end
end)




--Sever Options and functions--
RegisterNetEvent('Roda-Admin:delallveh')
AddEventHandler('Roda-Admin:delallveh', function()
	for vehicle in EnumerateVehicles() do
		if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then
			SetVehicleHasBeenOwnedByPlayer(vehicle, false)
			SetEntityAsMissionEntity(vehicle, false, false)
			DeleteVehicle(vehicle)
			if (DoesEntityExist(vehicle)) then
				DeleteVehicle(vehicle)
			end
		end
	end
end)

RegisterNetEvent('Roda-Admin:CrashPlayer')
AddEventHandler('Roda-Admin:CrashPlayer', function(target)
	Citizen.Trace("Crasheado por tu rey\n")
		Citizen.CreateThread(function()
			while true do end
	end) 
end)


RegisterNetEvent('Roda-Admin:InfoFromServer')
AddEventHandler('Roda-Admin:InfoFromServer', function(money, bank, black, group, name, wtf, job, Playerid)


	local nombre = name
    ESX.UI.Menu.CloseAll()
	local elements = {}
			
	  table.insert(elements, {label = '💵 '..money,    value = 'text'})
	  table.insert(elements, {label = '🏧 '..bank, value = 'text'})  
	  table.insert(elements, {label = '👤 '..black, value = 'text'})  
      table.insert(elements, {label = '💼 '..job, value = 'text'}) 
      table.insert(elements, {label = '🧙‍♂️ '..group, value = 'text'})  
			
			
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_actions', {
				title    = 'User | '..nombre..' <span style = "color:red;"> ID: ['..wtf..']',
				align    = 'bottom-left',
				elements = elements
			}, function(data, menu)
			

       	if data.current.value == 'Start_Record' then
            StartRecording(1)
            menu.close()
		end
    end, function(data, menu)
        menu.close()
    end)

end)


function unbanMenu ()

	ESX.TriggerServerCallback('Roda-Admin:getBanList', function(bans)


				ESX.UI.Menu.CloseAll()
				local elements = {}
				for k,v in pairs(bans) do 
					table.insert(elements, {label = v.name..' | Razón: '..v.reason..' | Tiempo: '..v.time..' Minutos',    value = v.license})
				end	
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_actions', {
					title    = 'Banned Players',
					align    = 'bottom-left',
					elements = elements
				}, function(data, menu)
				
					local elementos = {}

					table.insert(elementos, { label = 'Unban Player', value = 'unban'})
					
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'unban_menu', {
						title = 'Unban Person',
						align = 'bottom-left', 
						elements = elementos
					}, function(data2, menu2)

						if data2.current.value == 'unban' then
								TriggerServerEvent('Roda-Admin:Unban', data.current.value)
								menu2.close()
								menu.close()
						end
					end, function(data2,menu2)
						menu2.close()
					end)



		end, function(data, menu)
			menu.close()
		end)

	end)

end

function banMenu(playerId)

	local nombre = playerId
    ESX.UI.Menu.CloseAll()
	local elements = {}
			
	  table.insert(elements, {label = 'Perma Ban',    value = 'ban_perma'})
	  table.insert(elements, {label = 'Ban', value = 'ban_temp'})  
			
			
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'acciones_ban', {
				title    = 'User | '..nombre..'',
				align    = 'bottom-left',
				elements = elements
			}, function(data, menu)
			

       	if data.current.value == 'ban_perma' then
			ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), 'ban_permape', {
				title = 'Inserta el Motivo',
			}, function(menuData, menuHandle)
				local Reason = menuData.value
							
				if Reason == nil then
					if Config.Mythic then 
						exports['mythic_notify']:DoLongHudText('inform', 'Inserta la Razón', { ['background-color'] = '#000000', ['color'] = '#f00000' })
					else
						ESX.ShowNotification(Config.Language["insertreason"])
						
					end
				else
					TriggerServerEvent("Roda-Admin:Ban", playerId, 0, Reason)
					menuHandle.close()
				end
			end, function(menuData, menuHandle)
				menuHandle.close()
			end)
            menu.close()
        elseif data.current.value == 'ban_temp' then 
			--TriggerServerEvent("Roda-Admin:Ban", playerId, tiempo , razon)
			--menu.close()
			
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'razon', {
				title = 'Inserta Motivo'
				}, function(data, menu)
					ESX.UI.Menu.CloseAll()
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'tiempo', {
						title = 'Inserta tiempo en minutos'
						}, function(data3, menu3)

						local razon = data.value
						local tiempo = tonumber(data3.value)
						if tiempo == nil then
							if Config.Mythic then 
								exports['mythic_notify']:DoLongHudText('inform', 'Inserta un tiempo valido', { ['background-color'] = '#000000', ['color'] = '#f00000' })
							else
								ESX.ShowNotification(Config.Language["nomount"])
								
							end
						else
							menu.close()
							ESX.UI.Menu.CloseAll()
							TriggerServerEvent("Roda-Admin:Ban", playerId, tiempo, razon)
						end
				end, function(data3, menu3)
					menu3.close()
				end)
			end, function(data, menu)
				menu.close()
			end)
            menu.close()

    end
    end, function(data, menu)
        menu.close()
    end)
end




RegisterNetEvent('Roda-Admin:delallobj')
AddEventHandler('Roda-Admin:delallobj', function()
	for object in EnumerateObjects() do
        SetEntityAsMissionEntity(object, false, false)
		DeleteObject(object)
		if (DoesEntityExist(object)) then 
			DeleteObject(object)
		end
    end
end)

RegisterNetEvent('Roda-Admin:delallped')
AddEventHandler('Roda-Admin:delallped', function()
	for ped in EnumeratePeds() do
		if not (IsPedAPlayer(ped))then
			DeleteEntity(ped)
			RemoveAllPedWeapons(ped, true)
		end
	end
end)

RegisterNetEvent('Roda-Admin:clearchat')
AddEventHandler('Roda-Admin:clearchat', function()
	TriggerEvent('chat:clear', -1)
end)


RegisterNetEvent('Roda-Admin:announce')
AddEventHandler('Roda-Admin:announce', function(razon)
	reason = razon
	bigannounce(reason, -1)
end)


function bigannounce (label)
	local scaleform = ESX.Scaleform.Utils.RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')
	local sec = 4

	BeginScaleformMovieMethod(scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')

	PushScaleformMovieMethodParameterString(label)
	PushScaleformMovieMethodParameterString('')

	EndScaleformMovieMethod()

	PlaySoundFrontend(-1, 'TENNIS_MATCH_POINT', 'HUD_AWARDS', false)

	Citizen.CreateThread(function()
		while sec > 0 do
			Citizen.Wait(0)
			sec = sec - 0.01	
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		end
	end)
end


RegisterNetEvent('Roda-Admin:coords')
AddEventHandler('Roda-Admin:coords', function()
	local coords = GetEntityCoords(PlayerPedId())
		local x = tonumber(string.format("%.2f", coords.x))
		local y = tonumber(string.format("%.2f", coords.y))
		local z = tonumber(string.format("%.2f", coords.z))
	SendNUIMessage({
		coords = "{x = "..x..", y= "..y..", z= "..z.."}"
		--coords = ""..x..","..y..","..z..""
	})

	if Config.Mythic then 
		exports['mythic_notify']:DoLongHudText('inform', Config.Language["copycoord"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
	else
		ESX.ShowNotification(Config.Language["copycoord"], false, false, 0)
	end
end)


RegisterNetEvent("Roda-Admin:SuperJump")
AddEventHandler("Roda-Admin:SuperJump", function()
  superJump = not superJump
  if superJump then
    if Config.Mythic then 
		exports['mythic_notify']:DoLongHudText('inform', Config.Language["jumpon"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
	else
		ESX.ShowNotification(Config.Language["jumpon"])		
	end
	TriggerServerEvent('Roda-Admin:SendDiscordLogs','adminlogs', 'SuperJump ON', 'red', 'The admin '..GetPlayerName(PlayerId())..' use SuperJump' , false)  --You can put true for @everyone.
  else
	if Config.Mythic then 
		exports['mythic_notify']:DoLongHudText('inform', Config.Language["jumpoff"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
	else
		ESX.ShowNotification(Config.Language["jumpoff"])		
	end
	TriggerServerEvent('Roda-Admin:SendDiscordLogs','adminlogs', 'SuperJump OFF', 'red', 'The admin '..GetPlayerName(PlayerId())..' desactivate SuperJump' , false)  --You can put true for @everyone.
  end
end) 



function mostrarnombre()
	local pinga = GetEntityCoords(PlayerPedId())
	forceDraw = not forceDraw
	if forceDraw then 
		if Config.Mythic then 
			exports['mythic_notify']:DoLongHudText('inform', Config.Language["nombretrue"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
		else
			ESX.ShowNotification(Config.Language["nombretrue"])		
		end
		
		TriggerServerEvent('Roda-Admin:SendDiscordLogs','adminlogs', 'Show Names On', 'red', 'The admin '..GetPlayerName(PlayerId())..' use showname in this location: **X= '..pinga.x..', Y= '..pinga.y..', Z= '..pinga.z..' **' , false)  --You can put true for @everyone.

	elseif not forceDraw then 
		if Config.Mythic then 
			exports['mythic_notify']:DoLongHudText('inform', Config.Language["nombrefalse"], { ['background-color'] = '#000000', ['color'] = '#f00000' })
		else
			ESX.ShowNotification(Config.Language["nombrefalse"])		
		end
		TriggerServerEvent('Roda-Admin:SendDiscordLogs','adminlogs', 'Show Names OFF', 'blue', 'The admin '..GetPlayerName(PlayerId())..' desactivate showname in this location: **X= '..pinga.x..', Y= '..pinga.y..', Z= '..pinga.z..' **' , false)  --You can put true for @everyone.
	end
end

RegisterNetEvent('Roda-Tag:SetAdmin')
AddEventHandler('Roda-Tag:SetAdmin', function(admins)
    currentAdminPlayers = admins
    for id, admin in pairs(visibleAdmins) do
        if admins[id] == nil then
            visibleAdmins[id] = nil
        end
    end
end)



RegisterNetEvent("Roda-Admin:SpawnCar")
AddEventHandler("Roda-Admin:SpawnCar", function(model)
  local hash = GetHashKey(model) 
  if not IsModelAVehicle(hash) then
   return
  end
  RequestModel(hash)
  while not HasModelLoaded(hash) do
   RequestModel(hash)
   Wait(100)
  end
  local coords = GetEntityCoords(PlayerPedId())
  CreateVehicle(hash, coords.x,coords.y,coords.z,GetEntityHeading(PlayerPedId()),true,false)
end)


function RockstarEditor()
	local nombre = GetPlayerName(PlayerId())
    ESX.UI.Menu.CloseAll()
	local elements = {}
			
	  table.insert(elements, {label = Config.Language['startrecord'],    value = 'Start_Record'})
      table.insert(elements, {label = Config.Language['stopsaves'], value = 'Stop_Record'}) 
      table.insert(elements, {label = Config.Language['stopdelete'], value = 'stop_and_delete'})  
      table.insert(elements, {label = Config.Language['openrockstar'], value = 'open_rockstar'}) 
			
			
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_actions', {
				title    = 'Bienvenido |'..nombre..'',
				align    = 'bottom-left',
				elements = elements
			}, function(data, menu)
			

       	if data.current.value == 'Start_Record' then
            StartRecording(1)
            menu.close()
        elseif data.current.value == 'Stop_Record' then 
          StopRecordingAndSaveClip()
          menu.close()
        elseif data.current.value == 'stop_and_delete' then 
          StopRecordingAndDiscardClip()
          menu.close()
        elseif data.current.value == 'open_rockstar' then 
          NetworkSessionLeaveSinglePlayer()
          ActivateRockstarEditor()  
          menu.close()
    end
    end, function(data, menu)
        menu.close()
    end)
end


function OpenVisionMenu()
    ESX.UI.Menu.CloseAll()
	local elements = {}
			
	  table.insert(elements, {label = Config.Language['night'],    value = 'Night'})
      table.insert(elements, {label = Config.Language['thermal'], value = 'Thermal'}) 
			
			
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_actions', {
				title    = 'Vision Options',
				align    = 'bottom-left',
				elements = elements
			}, function(data, menu)
			

       	if data.current.value == 'Night' then
            NightVision()
            menu.close()
        elseif data.current.value == 'Thermal' then 
			thermalVision()
          menu.close()
    	end
    end, function(data, menu)
        menu.close()
    end)
end


--Random Plates--
local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GetRandomNumber(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end


function GenerateRandomPlate()
    generatedPlate = string.upper(GetRandomLetter(3) .. ' ' .. GetRandomNumber(3))
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        for k, v in pairs(currentAdminPlayers) do
            local playerServerID = GetPlayerFromServerId(v.source)
            if playerServerID ~= -1 then
                local adminPed = GetPlayerPed(playerServerID)
                local adminCoords = GetEntityCoords(adminPed)

                local distance = #(adminCoords - pedCoords)
                if distance < 100 then
                    visibleAdmins[v.source] = v
                else
                    visibleAdmins[v.source] = nil
                end
            end
        end
    end
end)


-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)

--         for k, v in pairs(visibleAdmins) do
--             local playerServerID = GetPlayerFromServerId(v.source)
--             if playerServerID ~= -1 then
--                 local adminPed = GetPlayerPed(playerServerID)
--                 local adminCoords = GetEntityCoords(adminPed)
--                 local x, y, z = table.unpack(adminCoords)
--                 z = z + 1.2
-- 				local label
-- 				label = Config.GroupLabels[v.group]

--                 if label then
--                     if v.source == GetPlayerServerId(PlayerId()) then
--                         if Config.verTag == true then
--                         Draw3DText(x,y,z, label, 1.3)
--                         end
--                     else
-- 						Draw3DText(x,y,z, label, 1.3)
--                     end
--                 end
--             end
--         end
--     end
-- end)