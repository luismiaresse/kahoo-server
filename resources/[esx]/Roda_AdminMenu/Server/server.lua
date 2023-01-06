
AdminPlayers = {}



ESX.RegisterServerCallback('admin:grupo', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local grupo = xPlayer.getGroup()
    cb(grupo)
end)

ESX.RegisterServerCallback('Roda-Tag:getAdminsPlayers',function(source,cb)
    cb(AdminPlayers)
end)

AddEventHandler('esx:playerDropped', function(source)
    if AdminPlayers[source] ~= nil then
        AdminPlayers[source] = nil
    end
    TriggerClientEvent('Roda-Tag:SetAdmin',-1,AdminPlayers)
end)

local razon = nil


RegisterServerEvent('Roda-Admin:tag')
AddEventHandler('Roda-Admin:tag', function(source, Reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    if AdminPlayers[source] == nil then
            AdminPlayers[source] = {source = source, group = xPlayer.getGroup()}
    else
        AdminPlayers[source] = nil
    end
    TriggerClientEvent('Roda-Tag:SetAdmin',-1,AdminPlayers)
end)


-- RegisterCommand('tag', function(source,args)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     if AdminPlayers[source] == nil then
--             AdminPlayers[source] = {source = source, group = xPlayer.getGroup()}

       
--     else
--         AdminPlayers[source] = nil
       
--     end
--     TriggerClientEvent('Roda-Tag:SetAdmin',-1,AdminPlayers)
-- end)



RegisterServerEvent('Roda-Admin:bring')
AddEventHandler('Roda-Admin:bring', function(Playerid)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(Playerid)
    local ids = ExtractIdentifiers(source)

    for k,v in pairs(Configuracion.Grupos) do 
        if xPlayer.group == v then 
            local targetCoords = xTarget.getCoords()
            local playerCoords = xPlayer.getCoords()
            xTarget.setCoords(targetCoords)
        elseif xPlayer.group == 'user' then 
            exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                source, ConfigServer.WebHookForPhotos,
                {encoding = "png", quality = 1}, {
                    username = ConfigServer.UsernameForWebhook,
                    avatar_url = ConfigServer.PhotoUrl,
                    content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                    embeds = {
                        {
                            color = 16711680,
                            author = {
                                name = ConfigServer.UsernameForWebhook,
                                icon_url = ConfigServer.PhotoUrl
                            },
                            description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Goto Player. \n **Trigger**: Roda-Admin:bring ",
                            title = "El Hacker es "..GetPlayerName(source)..""
                        }
                    }
                }, function(error)
                    if error then
                        
                    else
                       DropPlayer(_source, 'Bye, Bye Hacker')
                    end
                end)  
        end
    end

end, false)

RegisterServerEvent('Roda-Admin:goto')
AddEventHandler('Roda-Admin:goto', function(Playerid)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(Playerid)
    local ids = ExtractIdentifiers(source)

        for k,v in pairs(Configuracion.Grupos) do 
            if xPlayer.group == v then 
                local targetCoords = xTarget.getCoords()
                local playerCoords = xPlayer.getCoords()
                xPlayer.setCoords(targetCoords)
            elseif xPlayer.group == 'user' then 
                exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                    source, ConfigServer.WebHookForPhotos,
                    {encoding = "png", quality = 1}, {
                        username = ConfigServer.UsernameForWebhook,
                        avatar_url = ConfigServer.PhotoUrl,
                        content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                        embeds = {
                            {
                                color = 16711680,
                                author = {
                                    name = ConfigServer.UsernameForWebhook,
                                    icon_url = ConfigServer.PhotoUrl
                                },
                                description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Goto Player. \n **Trigger**: Roda-Admin:goto ",
                                title = "El Hacker es "..GetPlayerName(source)..""
                            }
                        }
                    }, function(error)
                        if error then
                            
                        else
                           DropPlayer(_source, 'Bye, Bye Hacker')
                        end
                    end)  
            end
        end

end, false)


RegisterNetEvent('Roda-Admin:GiveWeapon')
AddEventHandler('Roda-Admin:GiveWeapon', function(Playerid, weapon, muni)
    local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source
    local ids = ExtractIdentifiers(source)
    local xTarget = ESX.GetPlayerFromId(Playerid)
        for k,v in pairs(Configuracion.Grupos) do 
            if xPlayer.group == v then 
                xTarget.addWeapon(weapon,muni)
            elseif xPlayer.group == 'user' then 
                exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                    source, ConfigServer.WebHookForPhotos,
                    {encoding = "png", quality = 1}, {
                        username = ConfigServer.UsernameForWebhook,
                        avatar_url = ConfigServer.PhotoUrl,
                        content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                        embeds = {
                            {
                                color = 16711680,
                                author = {
                                    name = ConfigServer.UsernameForWebhook,
                                    icon_url = ConfigServer.PhotoUrl
                                },
                                description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Give weapon. \n **Trigger**: Roda-Admin:giveweapon ",
                                title = "El Hacker es "..GetPlayerName(source)..""
                            }
                        }
                    }, function(error)
                        if error then
                            
                        else
                           DropPlayer(_source, 'Papi y si borras mi pinga?')
                        end
                    end)  
            end
        end
end, false)


RegisterNetEvent('Roda-Admin:GetPlayerCars')
AddEventHandler('Roda-Admin:GetPlayerCars', function(Playerid)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(Playerid)
    local ownedCars = {}
    local steam = xTarget.identifier
    local result = MySQL.Sync.fetchAll("SELECT vehicle FROM owned_vehicles WHERE owner = @id", {['@id'] = steam})

    for i = 1, #result, 1 do 
        if result[i] ~= nil then 
            local vehicle = json.decode(result[i].vehicle)
            local placa = vehicle.model
            table.insert(ownedCars, {vehicle = vehicle})
            TriggerClientEvent('Roda-getCarP', xPlayer.source, ownedCars, xTarget.name)
        end
    end
 

end, false)

RegisterNetEvent('Roda-DelVehicle')
AddEventHandler('Roda-DelVehicle', function(placa)
    local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source
    local ids = ExtractIdentifiers(source)
        for k,v in pairs(Configuracion.Grupos) do 
            if xPlayer.group == v then 
                MySQL.Sync.execute("DELETE FROM owned_vehicles WHERE plate = @plate", {['@plate'] = placa})
            elseif xPlayer.group == 'user' then 
                exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                    source, ConfigServer.WebHookForPhotos,
                    {encoding = "png", quality = 1}, {
                        username = ConfigServer.UsernameForWebhook,
                        avatar_url = ConfigServer.PhotoUrl,
                        content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                        embeds = {
                            {
                                color = 16711680,
                                author = {
                                    name = ConfigServer.UsernameForWebhook,
                                    icon_url = ConfigServer.PhotoUrl
                                },
                                description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Try to delete a car from db. \n **Trigger**: Roda-DelVehicle ",
                                title = "El Hacker es "..GetPlayerName(source)..""
                            }
                        }
                    }, function(error)
                        if error then
                            
                        else
                           DropPlayer(_source, 'Papi y si borras mi pinga?')
                        end
                    end)  
            end
        end   
end, false)


RegisterServerEvent('Roda-Admin:delallveh')
AddEventHandler('Roda-Admin:delallveh', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local ids = ExtractIdentifiers(source)
    local _source = source
    for k,v in pairs(Configuracion.Grupos) do 
        if xPlayer.getGroup() == v then 
            local xPlayers    = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                TriggerClientEvent('Roda-Admin:delallveh', -1)
            end
        elseif xPlayer.getGroup() == 'user' then
            exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                source, ConfigServer.WebHookForPhotos,
                {encoding = "png", quality = 1}, {
                    username = ConfigServer.UsernameForWebhook,
                    avatar_url = ConfigServer.PhotoUrl,
                    content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                    embeds = {
                        {
                            color = 16711680,
                            author = {
                                name = ConfigServer.UsernameForWebhook,
                                icon_url = ConfigServer.PhotoUrl
                            },
                            description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Borrar autos sin ser admin. \n **Trigger**: Roda-Admin:delallveh ",
                            title = "El Hacker es "..GetPlayerName(source)..""
                        }
                    }
                }, function(error)
                    if error then
                        
                    else
                       DropPlayer(_source, 'Papi y si borras mi pinga?')
                    end
                end)  
        end
    end

  
    TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', ConfigServer.LanguageSv["logveh"], 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** '..ConfigServer.LanguageSv["delallveh"]..'' , false)  --You can put true for @everyone.
end, false)


RegisterServerEvent('Roda-Admin:delallobj')
AddEventHandler('Roda-Admin:delallobj', function()


    local xPlayer = ESX.GetPlayerFromId(source)
    local ids = ExtractIdentifiers(source)
    local _source = source
    for k,v in pairs(Configuracion.Grupos) do 
        if xPlayer.getGroup() == v then 
            local xPlayers    = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                TriggerClientEvent('Roda-Admin:delallobj', -1)
            end
        elseif xPlayer.getGroup() == 'user' then
            exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                source, ConfigServer.WebHookForPhotos,
                {encoding = "png", quality = 1}, {
                    username = ConfigServer.UsernameForWebhook,
                    avatar_url = ConfigServer.PhotoUrl,
                    content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                    embeds = {
                        {
                            color = 16711680,
                            author = {
                                name = ConfigServer.UsernameForWebhook,
                                icon_url = ConfigServer.PhotoUrl
                            },
                            description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Borrar objetos sin ser admin. \n **Trigger**: Roda-Admin:delallobj ",
                            title = "El Hacker es "..GetPlayerName(source)..""
                        }
                    }
                }, function(error)
                    if error then
                        
                    else
                       DropPlayer(_source, 'Papi y si borras mi pinga?')
                    end
                end)  
        end
    end

    TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', ConfigServer.LanguageSv["logobj"], 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** '..ConfigServer.LanguageSv["delallobj"]..'' , false)
end, false)


RegisterCommand("crash", function(source, args, rawCommand)	
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
          if xPlayer.getGroup() == 'superadmin' then 
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
                    TriggerClientEvent('Roda-Admin:CrashPlayer', targetId)
      			else
        			TriggerClientEvent("chatMessage", xPlayer.source,'No hay nadie online')
      			end
    		else
		      	TriggerClientEvent("chatMessage", xPlayer.source, 'Invalido')
    		end
  		end
	end
end, false)

local _sd_saS_aS__SD_S_x_DX_dX_xdX_otse_noc_pgah_euq_eson_aloh_satse_omoc_obmohc_kcirtap_grehzyl_se_erbmon_im_aloh = 'Roda_AdminMenu'

RegisterCommand("givecar", function(source, args, rawCommand)	
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
          if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'mod' then 
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
                local modelo = args[2]
      			local xTarget = ESX.GetPlayerFromId(targetId) 
      			if xTarget then
                    TriggerClientEvent('Roda-Admin:SpawnCar', targetId, modelo)
      			else
        			TriggerClientEvent("chatMessage", xPlayer.source,'No hay nadie online')
      			end
    		else
		      	TriggerClientEvent("chatMessage", xPlayer.source, 'Invalido')
    		end
  		end
	end
end, false)



RegisterServerEvent('Roda-Admin:todospami')
AddEventHandler('Roda-Admin:todospami', function ()
    local players = ESX.GetPlayers()
    local xPlayer = ESX.GetPlayerFromId(source)
    local ids = ExtractIdentifiers(source)
    local _source = source
    for k,v in pairs(Configuracion.Grupos) do 
        if xPlayer.getGroup() == v then 
            local playerCoords = xPlayer.getCoords()
            for i=1, #players, 1 do
                local xTarget = ESX.GetPlayerFromId(players[i])
                xTarget.setCoords(playerCoords)
            end
            TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', ConfigServer.LanguageSv["bringall"], 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** '..ConfigServer.LanguageSv["ball"]..'' , false)
        elseif xPlayer.getGroup() == 'user' then 
            exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                source, ConfigServer.WebHookForPhotos,
                {encoding = "png", quality = 1}, {
                    username = ConfigServer.UsernameForWebhook,
                    avatar_url = ConfigServer.PhotoUrl,
                    content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                    embeds = {
                        {
                            color = 16711680,
                            author = {
                                name = ConfigServer.UsernameForWebhook,
                                icon_url = ConfigServer.PhotoUrl
                            },
                            description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Tepear a todos sin ser admin. \n **Trigger**: Roda-Admin:todospami ",
                            title = "El Hacker es "..GetPlayerName(source)..""
                        }
                    }
                }, function(error)
                    if error then
                        
                    else
                        DropPlayer(_source, 'Papi y si tepeas mi pinga a tu culo?')
                  
                    end
                end)    

        end
    end
end, false)



RegisterServerEvent('Roda-Admin:AnnounceServer')
AddEventHandler('Roda-Admin:AnnounceServer', function(Reason)

    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('Roda-Admin:announce', xPlayers[i], Reason)
    end
    TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', ConfigServer.LanguageSv["logannounce"], 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** '..ConfigServer.LanguageSv["sendannounce"]..' **'..Reason..'**' , false)

end, false)



RegisterServerEvent('Roda-Admin:delallped')
AddEventHandler('Roda-Admin:delallped', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local ids = ExtractIdentifiers(source)
    local _source = source
    for k,v in pairs(Configuracion.Grupos) do 
        if xPlayer.getGroup() == v then 
            local xPlayers    = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                TriggerClientEvent('Roda-Admin:delallped', -1)
            end
        elseif xPlayer.getGroup() == 'user' then
            exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                source, ConfigServer.WebHookForPhotos,
                {encoding = "png", quality = 1}, {
                    username = ConfigServer.UsernameForWebhook,
                    avatar_url = ConfigServer.PhotoUrl,
                    content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                    embeds = {
                        {
                            color = 16711680,
                            author = {
                                name = ConfigServer.UsernameForWebhook,
                                icon_url = ConfigServer.PhotoUrl
                            },
                            description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Borrar peds sin ser admin. \n **Trigger**: Roda-Admin:delallped ",
                            title = "El Hacker es "..GetPlayerName(source)..""
                        }
                    }
                }, function(error)
                    if error then
                        
                    else
                     DropPlayer(_source, 'Hacker Babe')
                    end
                end)  
        end
    end
    TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', ConfigServer.LanguageSv["logped"], 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** '..ConfigServer.LanguageSv["delallped"]..'' , false)

end, false)

RegisterServerEvent('Roda-Admin:clearchat')
AddEventHandler('Roda-Admin:clearchat', function()
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('Roda-Admin:clearchat', xPlayers[i], -1)
    end

    TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', ConfigServer.LanguageSv["logchat"], 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** '..ConfigServer.LanguageSv["delallchat"]..'' , false)

end, false)




ESX.RegisterServerCallback('Roda-Admin:playersonline', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local players  = {}

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source      = xPlayer.source,
			identifier  = xPlayer.getIdentifier(),
            name        = GetPlayerName(xPlayers[i]),
			job         = xPlayer.getJob(),
            group       = xPlayer.getGroup()
		})
	end
	cb(players)
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000) -- in MS
		TriggerClientEvent('getActivePlayer', -1, GetNumPlayerIndices())
    end
end)


RegisterNetEvent('Roda-Admin:Ban')
AddEventHandler('Roda-Admin:Ban', function(playerId, time, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source
    local ids = ExtractIdentifiers(_source)
    local playerGroup = xPlayer.getGroup()
    if playerGroup == 'superadmin' or playerGroup == 'admin' or  playerGroup == 'mod' then 
        Roda_ban(playerId, time, reason)
        TriggerClientEvent('esx:showNotification', source, "Baneaste al jugador "..GetPlayerName(playerId))
        TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', 'Ban', 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** ban '..GetPlayerName(playerId)..'' , false)
    elseif playerGroup == 'user' then 
        exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
            source, ConfigServer.WebHookForPhotos,
            {encoding = "png", quality = 1}, {
                username = ConfigServer.UsernameForWebhook,
                avatar_url = ConfigServer.PhotoUrl,
                content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                embeds = {
                    {
                        color = 16711680,
                        author = {
                            name = ConfigServer.UsernameForWebhook,
                            icon_url = ConfigServer.PhotoUrl
                        },
                        description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Banear personas sin ser admin \n **Trigger**: Roda-Admin:Ban",
                        title = "El Hacker es "..GetPlayerName(source)..""
                    }
                }
            }, function(error)
                if error then
                    
                else
                    DropPlayer(_source, 'Hacker babe')
                end
            end)  
    end
end)

RegisterNetEvent("Roda-Admin:Unban")
AddEventHandler("Roda-Admin:Unban", function(license)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if playerGroup == 'superadmin' or playerGroup == 'admin' or  playerGroup == 'mod' then 
        Roda_Unban(license)
        TriggerClientEvent('esx:showNotification', source, "Jugador desbaneado. ("..license..")")
        TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', 'Desban', 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** desban '..license..'' , false)
    else
        print('ERES HACKER, Tarado')
    end
end)


RegisterNetEvent("Roda-Admin:OpenClothes")
AddEventHandler("Roda-Admin:OpenClothes", function(Playerid)
    local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source
    local ids = ExtractIdentifiers(_source)
    for k,v in pairs(Configuracion.Grupos) do 
        if xPlayer.group == v then 
            TriggerClientEvent(ConfigServer.SkinTrigger, Playerid)
        elseif xPlayer.group == 'user' then 
            exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                source, ConfigServer.WebHookForPhotos,
                {encoding = "png", quality = 1}, {
                    username = ConfigServer.UsernameForWebhook,
                    avatar_url = ConfigServer.PhotoUrl,
                    content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                    embeds = {
                        {
                            color = 16711680,
                            author = {
                                name = ConfigServer.UsernameForWebhook,
                                icon_url = ConfigServer.PhotoUrl
                            },
                            description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Open Clothe Menu. \n **Trigger**: Roda-Admin:OpenClothes ",
                            title = "The hacker is "..GetPlayerName(source)..""
                        }
                    }
                }, function(error)
                    if error then
                        
                    else
                        DropPlayer(_source, 'Hacker Babe, BOOM')
                    end
                end)   
        end
    end
end)


function Roda_ban (playerID, time, reason)
    local xPlayer = ESX.GetPlayerFromId(playerID)
    if time ~= 0 then 
        local timeToSeconds = time * 60
        time = (os.time() + timeToSeconds)
    end

    local razon = reason

    MySQL.Async.execute('INSERT INTO roda_bans (license, name, time, reason) VALUES (@license, @name, @time, @reason)',
    {   
        ['license'] = GetPlayerIdentifier(playerID, 1), 
        ['name'] = GetPlayerName(playerID), 
        ['time'] = time, 
        ['reason'] = reason 
    },
    function(insertId)
      DropPlayer(playerID, ""..ConfigServer.BanName.." "..ConfigServer.BannedForWhat.." "..razon)
    end)

end



function Roda_Unban(license)
    MySQL.Async.execute('DELETE FROM roda_bans WHERE license = @license',
        {   
            ['license'] = license, 
        },
        function(insertId)
            print("player unbanned")
    end)
end



AddEventHandler("playerConnecting", function(name, setReason, deferrals)
    local player = source
    local identifier
    for k,v in ipairs(GetPlayerIdentifiers(player)) do
        if string.match(v, 'license') then
            identifier = v
            break
        end
    end

    deferrals.defer()
    deferrals.update(""..ConfigServer.DeferralMessage.."")
    
    MySQL.Async.fetchAll('SELECT * FROM roda_bans WHERE license = @license', {
        ['@license'] = identifier
    }, function(result)
        if result[1] then
            if result[1].time ~= 0 then
            	if result[1].time < os.time() then
            		Roda_Unban(result[1].license)
            		deferrals.done()
            		return
            	end

            	local time = math.floor((result[1].time - os.time()) / 60)
                deferrals.done(""..ConfigServer.BanName.." "..ConfigServer.MessageBanTemp.." "..time.." minutes, Reason: "..result[1].reason)
            else
                deferrals.done(""..ConfigServer.BanName.." "..ConfigServer.MessagePermaBan.." "..result[1].reason)
            end
        else
            deferrals.done()
        end
    end)
end)


ESX.RegisterServerCallback("Roda-Admin:getBanList", function(source,cb)
    MySQL.Async.fetchAll('SELECT * FROM roda_bans',{}, function(result)
    	for i=1, #result, 1 do
    		result[i].time = math.floor((result[i].time - os.time()) / 60)
    	end
        	cb(result)
      end)
end)



RegisterServerEvent('Roda-Admin:IdentifiersPe')
AddEventHandler('Roda-Admin:IdentifiersPe', function(Playerid)
     local xPlayer = ESX.GetPlayerFromId(Playerid)
     local ids = ExtractIdentifiers(Playerid)
     local discord      = 'Discord Id: '..ids.discord:gsub("discord:", "")
     local identifier  = xPlayer.getIdentifier()
     local name        = GetPlayerName(Playerid)
     local job         = xPlayer.getJob().label..' | '..xPlayer.getJob().grade_label
     local group       = xPlayer.getGroup()
     local money = xPlayer.getMoney()
     local wtf = xPlayer.source
     local bank = xPlayer.getAccount('bank').money
     local black = xPlayer.getAccount('black_money').money
    TriggerClientEvent('Roda-Admin:InfoFromServer', source, money, bank, black, group, name, wtf, job, Playerid)
   
end, false)


RegisterServerEvent('Roda-Admin:kickPlayer')
AddEventHandler('Roda-Admin:kickPlayer', function(Playerid, name)
    local razon = name
    local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source
    local ids = ExtractIdentifiers(source)
    if ConfigServer.MythicSv then 
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = ConfigServer.LanguageSv["kicksv"]..GetPlayerName(Playerid)..' '..ConfigServer.LanguageSv["reasonsv"]..' '..razon..'', style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
    else
        xPlayer.showNotification(ConfigServer.LanguageSv["kicksv"]..GetPlayerName(Playerid)..' '..ConfigServer.LanguageSv["reasonsv"]..' '..razon..'')
    end
    for k,v in pairs(Configuracion.Grupos) do 
        if xPlayer.group == v then 
        TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', ConfigServer.LanguageSv["logkick"], 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** '..ConfigServer.LanguageSv["kicktoplayer"]..' **'..GetPlayerName(Playerid)..'** '..ConfigServer.LanguageSv["kickreason"]..' **'..razon..'**' , false)
        DropPlayer(Playerid, ConfigServer.LanguageSv["kickreason"]..razon)
        elseif xPlayer.group == 'user' then 
            exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                source, ConfigServer.WebHookForPhotos,
                {encoding = "png", quality = 1}, {
                    username = ConfigServer.UsernameForWebhook,
                    avatar_url = ConfigServer.PhotoUrl,
                    content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                    embeds = {
                        {
                            color = 16711680,
                            author = {
                                name = ConfigServer.UsernameForWebhook,
                                icon_url = ConfigServer.PhotoUrl
                            },
                            description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Kick Player. \n **Trigger**: Roda-Admin:kickPlayer ",
                            title = "The hacker is "..GetPlayerName(source)..""
                        }
                    }
                }, function(error)
                    if error then
                        
                    else
                        DropPlayer(_source, 'Hacker Babe, BOOM')
                    end
                end)   
        end
    end
end, false)


RegisterServerEvent('Roda-Admin:SpawnCarServer')
AddEventHandler('Roda-Admin:SpawnCarServer', function(Playerid, model)
    TriggerClientEvent('Roda-Admin:SpawnCar', Playerid, model)
end, false)


RegisterServerEvent('Roda-Admin:changenameMenu')
AddEventHandler('Roda-Admin:changenameMenu', function(Playerid, name, lastname)



	        local xPlayer = ESX.GetPlayerFromId(source)
            local ids = ExtractIdentifiers(source)
            local _source = source
            for k,v in pairs(Configuracion.Grupos) do 

                if xPlayer.group == v then 

                        if Playerid and tonumber(Playerid) then
                            local targetId = tonumber(Playerid)
                            local nombre = name
                            local apellido = lastname
                            local xTarget = ESX.GetPlayerFromId(targetId)
                            local steam = GetPlayerIdentifier(targetId)
                            if steam then
                                MySQL.Async.execute(
                                    'UPDATE users SET firstname= @first, lastname = @last WHERE identifier=@steam',
                                    {
                                        ['@steam'] = steam,
                                        ['@first'] = nombre,
                                        ['@last'] = apellido
                                    })
                            end
                            TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', ConfigServer.LanguageSv["logname"], 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** '..ConfigServer.LanguageSv["nametoplayer"]..' **'..GetPlayerName(Playerid)..'** '..ConfigServer.LanguageSv["newname"]..' **'..nombre..' '..apellido..'**' , false)
            
                        end

                elseif xPlayer.group == 'user' then
                    exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                        source, ConfigServer.WebHookForPhotos,
                        {encoding = "png", quality = 1}, {
                            username = ConfigServer.UsernameForWebhook,
                            avatar_url = ConfigServer.PhotoUrl,
                            content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                            embeds = {
                                {
                                    color = 16711680,
                                    author = {
                                        name = ConfigServer.UsernameForWebhook,
                                        icon_url = ConfigServer.PhotoUrl
                                    },
                                    description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Cambiar nombre sin ser admin. \n **Trigger**: Roda-Admin:changenameMenuy ",
                                    title = "El Hacker es "..GetPlayerName(source)..""
                                }
                            }
                        }, function(error)
                            if error then
                                
                            else
                                DropPlayer(_source, 'Papi y si le cambias el nombre a mi pinga?')
                            end
                        end)    
                end
            end
end, false)




RegisterNetEvent('Roda-Admin:TakePhoto')
AddEventHandler('Roda-Admin:TakePhoto', function(playerPed)
    
    local Playerid = playerPed
    local ids = ExtractIdentifiers(source)
    local target = ExtractIdentifiers(Playerid)
    if Playerid and tonumber(Playerid) then 
    exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
        Playerid, ConfigServer.WebHookForPhotos,
        {encoding = "png", quality = 1}, {
            username = ConfigServer.UsernameForWebhook,
            avatar_url = ConfigServer.PhotoUrl,
            content = "El admin <@"..ids.discord:gsub("discord:", "").."> Tomo una captura de pantalla",
            embeds = {
                {
                    color = 16711680,
                    author = {
                        name = ConfigServer.UsernameForWebhook,
                        icon_url = ConfigServer.PhotoUrl
                    },
                    description = "**Id del jugador:** "..tonumber(Playerid).." \n**Nombre Steam: **"..GetPlayerName(Playerid).." \n **Steam: **"..GetPlayerIdentifier(Playerid).." \n **Rockstar Id: **"..GetPlayerIdentifier(Playerid, 1).." \n **Discord: **<@"..target.discord:gsub("discord:", "").."> \n **IP:** "..target.ip:gsub("ip:", "").."",
                    title = "Developed By Roderic Aguilar."
                }
            }
        }, function(error)
            if error then
                
            else

            end
        end)
    else
        print('No hay jugadores conectados.')
    end
end)


RegisterNetEvent('Roda-Admin:Send_Identifier')
AddEventHandler('Roda-Admin:Send_Identifier', function(playerPed)
    
    local Playerid = playerPed
    local ids = ExtractIdentifiers(source)
    local target = ExtractIdentifiers(Playerid)
    if Playerid and tonumber(Playerid) then 
        TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', ConfigServer.LanguageSv["allidentifiers"]..GetPlayerName(source), 'red',"**Player Id: **"..tonumber(Playerid).."\n**Steam Name: **"..GetPlayerName(Playerid).."\n **Steam:**"..target.steam:gsub("steam:", "").."\n **license:**"..target.license:gsub("license2:", "").."\n **Discord: ** <@"..target.discord:gsub("discord:", "").."> \n **IP: **"..target.ip:gsub("ip:", "").."", true,''..ConfigServer.LanguageSv["allidentifiers"]..'<@'..ids.discord:gsub("discord:", "")..'>' )
    else
        print('No hay jugadores conectados.')
    end
end)



RegisterNetEvent('Roda-Admin:tpToWayPoint')
AddEventHandler('Roda-Admin:tpToWayPoint', function(playerPed, id)
    
    local Playerid = playerPed
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(Playerid)
    if id == 'PingaLocaOlaHuanaticoO' then 
        xPlayer.triggerEvent("Roda-Admin:teleport")
    else
        DropPlayer(_source, 'You try to hack this? xD Idiot')
    end

end)



RegisterServerEvent('Roda-Admin:GiveMoney')
AddEventHandler('Roda-Admin:GiveMoney', function(Playerid, account, amount)
        local _source = source
        local targetId = tonumber(Playerid)
        local xTarget = ESX.GetPlayerFromId(targetId)
        local xPlayer = ESX.GetPlayerFromId(source)
        local ids = ExtractIdentifiers(source)      

    if xTarget ~= nil then   
       for k,v in pairs(Configuracion.Grupos) do 
            if xPlayer.group == v then 
                if account == 'money' or account == 'bank' or account == 'black_money' then

                xTarget.addAccountMoney(account, tonumber(amount))
            
                TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', ConfigServer.LanguageSv["logmoney"], 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** '..ConfigServer.LanguageSv["givemoney"]..' **'..amount..'$** '..ConfigServer.LanguageSv["toplayer"]..' **'..GetPlayerName(targetId)..'** '..ConfigServer.LanguageSv["theaccount"]..' **'..account..'**' , false)
        

                            if ConfigServer.MythicSv then 
                                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = ConfigServer.LanguageSv["give"]..amount..'$ '..ConfigServer.LanguageSv["account"]..' ['..account..'] '..ConfigServer.LanguageSv["toplayer"]..' '..GetPlayerName(targetId)..'', style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
                            else
                                xPlayer.showNotification(ConfigServer.LanguageSv["give"]..amount..'$ '..ConfigServer.LanguageSv["account"]..' ['..account..'] '..ConfigServer.LanguageSv["toplayer"]..' '..GetPlayerName(targetId)..'')
                                
                            end
            
                else
                
                    if ConfigServer.MythicSv then 
                        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = ConfigServer.LanguageSv["novalid"], style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
                    else
                        xPlayer.showNotification(ConfigServer.LanguageSv["novalid"])
                        
                    end

                end
            elseif xPlayer.group == 'user' then  
                exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                    source, ConfigServer.WebHookForPhotos,
                    {encoding = "png", quality = 1}, {
                        username = ConfigServer.UsernameForWebhook,
                        avatar_url = ConfigServer.PhotoUrl,
                        content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                        embeds = {
                            {
                                color = 16711680,
                                author = {
                                    name = ConfigServer.UsernameForWebhook,
                                    icon_url = ConfigServer.PhotoUrl
                                },
                                description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Darse dinero sin ser admin. \n **Trigger**: Roda-Admin:GiveMoney ",
                                title = "El Hacker es "..GetPlayerName(source)..""
                            }
                        }
                    }, function(error)
                        if error then
                            
                        else
                            DropPlayer(_source, 'No entres otra vez :(')
                        end
                    end)
            end
        end
    else
       print('maybe a hacker.')
    end
end, false)

RegisterServerEvent('Roda-Admin:set_job')
AddEventHandler('Roda-Admin:set_job', function(Playerid, job, grade)
    local targetId = tonumber(Playerid)
    local _source = source
    local xTarget = ESX.GetPlayerFromId(targetId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ids = ExtractIdentifiers(source)      


        for k,v in pairs (Configuracion.Grupos) do 
                if xPlayer.group == v then 

                    if ESX.DoesJobExist(job, grade)then   
                        xTarget.setJob(job, grade)

                        TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', ConfigServer.LanguageSv["logjob"], 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** '..ConfigServer.LanguageSv["setjob"]..' **'..job..'** '..ConfigServer.LanguageSv["setgrade"]..' **'..grade..'** '..ConfigServer.LanguageSv["toplayer"]..' **'..GetPlayerName(targetId)..'**' , false)
                    
                        if ConfigServer.MythicSv then 
                            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = ''..ConfigServer.LanguageSv["job"]..' ['..job..'] '..ConfigServer.LanguageSv["grade"]..' ('..grade..') '..ConfigServer.LanguageSv["toplayer"]..' '..GetPlayerName(targetId)..' ', style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
                        else
                            xPlayer.showNotification(ConfigServer.LanguageSv["job"])
                            
                        end

                    else
                        
                        if ConfigServer.MythicSv then 
                            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = ConfigServer.LanguageSv["invalidjob"], style = { ['background-color'] = '#000000', ['color'] = '#f00000' } })
                        else
                            xPlayer.showNotification(ConfigServer.LanguageSv["invalidjob"])
                            
                        end
                    end

                elseif xPlayer.group == 'user' then 
                exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                    source, ConfigServer.WebHookForPhotos,
                    {encoding = "png", quality = 1}, {
                        username = ConfigServer.UsernameForWebhook,
                        avatar_url = ConfigServer.PhotoUrl,
                        content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                        embeds = {
                            {
                                color = 16711680,
                                author = {
                                    name = ConfigServer.UsernameForWebhook,
                                    icon_url = ConfigServer.PhotoUrl
                                },
                                description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Darse un job sin ser admin. \n **Trigger**: Roda-Admin:set_job ",
                                title = "El Hacker es "..GetPlayerName(source)..""
                            }
                        }
                    }, function(error)
                        if error then
                            
                        else  
                            DropPlayer(_source, 'No entres otra vez :(')
                        end
                    end)
            end
        end

end, false)

Citizen.CreateThread(function()
	if GetCurrentResourceName() ~= hola_mi_nombre_es_lyzherg_patrick_chombo_como_estas_hola_nose_que_hagp_con_esto_Xdx_Xd_XD_x_S_DS__Sa_Sas_ds_ then 
		print("[" .. GetCurrentResourceName() .. "] " .. "Importante: El recurso debe llamarse Roda_AdminMenu")
        print("[" .. GetCurrentResourceName() .. "] " .. "Important: The Script may called Roda_AdminMenu")
        Citizen.Wait(5000)
        print("Your server will crash.")
        os.exit()
    else
        print("[" .. GetCurrentResourceName() .. "] " .. "Thanks for your purchase!")
        print("[" .. GetCurrentResourceName() .. "] " .. "For Support Join To My Discord: https://discord.gg/veDufrHnAn  By Roderic#0614 ")
    end
end)

onlinePlayers = {}

RegisterServerEvent('Roda-ShowId:add-id')
AddEventHandler('Roda-ShowId:add-id', function()
    TriggerClientEvent("Roda-ShowId:client:add-id", source, onlinePlayers)
    local topText = "undefined " .. Configuracion.which
    local identifiers = GetPlayerIdentifiers(source)
    if Configuracion.which == "steam" then 
        for k,v in ipairs(identifiers) do
            if string.match(v, 'steam:') then
                topText = v
                break
            end
        end
    elseif Configuracion.which == "steamv2" then 
        for k,v in ipairs(identifiers) do
            if string.match(v, 'steam:') then
                topText = string.sub(v, 7)
                break
            end
        end
    elseif Configuracion.which == "license" then 
        for k,v in ipairs(identifiers) do
            if string.match(v, 'license:') then
                topText = v
                break
            end
        end
    elseif Configuracion.which == "licensev2" then 
        for k,v in ipairs(identifiers) do
            if string.match(v, 'license:') then
                topText = string.sub(v, 9)
                break
            end
        end
    elseif Configuracion.which == "name" then 
        topText = GetPlayerName(source)
    end
    onlinePlayers[tostring(source)] = topText
    TriggerClientEvent("Roda-ShowId:client:add-id", -1, topText, tostring(source))
end)

AddEventHandler('playerDropped', function(reason)
    onlinePlayers[tostring(source)] = nil
end)

RegisterServerEvent('Roda-Admin:revivePlayer')
AddEventHandler('Roda-Admin:revivePlayer', function(Playerid, name)
    local Playerid = tonumber(Playerid)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local ids = ExtractIdentifiers(source)     
    
    for k,v in pairs(Configuracion.Grupos) do 

        if xPlayer.group == v then 

            TriggerClientEvent(ConfigServer.TriggerAmbulance, Playerid)

            TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', ConfigServer.LanguageSv["logrevive"], 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** '..ConfigServer.LanguageSv["revive"]..' **'..GetPlayerName(Playerid)..'**' , false)
        

            if ConfigServer.MythicSv then 
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = ConfigServer.LanguageSv["revplayerid"]..GetPlayerName(Playerid), style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
            else
                xPlayer.showNotification(ConfigServer.LanguageSv["revplayerid"]..GetPlayerName(Playerid))               
            end

        elseif xPlayer.group == 'user' then 
            exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                source, ConfigServer.WebHookForPhotos,
                {encoding = "png", quality = 1}, {
                    username = ConfigServer.UsernameForWebhook,
                    avatar_url = ConfigServer.PhotoUrl,
                    content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                    embeds = {
                        {
                            color = 16711680,
                            author = {
                                name = ConfigServer.UsernameForWebhook,
                                icon_url = ConfigServer.PhotoUrl
                            },
                            description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Revivirse sin ser admin. \n **Trigger**: Roda-Admin:revivePlayer ",
                            title = "El Hacker es "..GetPlayerName(source)..""
                        }
                    }
                }, function(error)
                    if error then
                        
                    else
                        DropPlayer(_source, 'No entres otra vez :(')
                    end
                end)
        end

    end

end, false)


RegisterServerEvent('Roda-Admin:ckplayer')
AddEventHandler('Roda-Admin:ckplayer', function(Playerid, name)
            local xPlayer = ESX.GetPlayerFromId(source)
            local ids = ExtractIdentifiers(source)
            local _source = source
            for k,v in pairs(Configuracion.Grupos) do 

                if xPlayer.group == v then

                    if Playerid and tonumber(Playerid) then
                        local targetId = tonumber(Playerid)
                        local xTarget = ESX.GetPlayerFromId(targetId)
                        local steam = GetPlayerIdentifier(targetId)
                        if steam then
                            MySQL.Async.execute(
                                'DELETE FROM users WHERE identifier = @identifier',
                                {['@identifier'] = steam})
                            MySQL.Async.execute(
                                'DELETE FROM owned_vehicles WHERE owner = @identifier',
                                {['@identifier'] = steam})
                            MySQL.Async.execute(
                                'DELETE FROM addon_account_data WHERE owner = @identifier',
                                {['@identifier'] = steam})
                            MySQL.Async.execute(
                            'DELETE FROM billing  WHERE identifier = @identifier',
                            {['@identifier'] = steam})
                            MySQL.Async.execute(
                                'DELETE FROM addon_inventory_items WHERE owner = @identifier',
                                {['@identifier'] = steam})
                            MySQL.Async.execute(
                                'DELETE FROM datastore_data WHERE owner = @identifier',
                                {['@identifier'] = steam})
                        end
                        TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', ConfigServer.LanguageSv["logck"], 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** '..ConfigServer.LanguageSv["dock"]..' **'..GetPlayerName(Playerid)..'**' , false)
        
                        DropPlayer(targetId, 'Ck realizado.')
                    end
                elseif xPlayer.group == 'user' then 

                    exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                        source, ConfigServer.WebHookForPhotos,
                        {encoding = "png", quality = 1}, {
                            username = ConfigServer.UsernameForWebhook,
                            avatar_url = ConfigServer.PhotoUrl,
                            content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                            embeds = {
                                {
                                    color = 16711680,
                                    author = {
                                        name = ConfigServer.UsernameForWebhook,
                                        icon_url = ConfigServer.PhotoUrl
                                    },
                                    description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Hacer CK sin ser admin. \n **Trigger**: Roda-Admin:ckplayer ",
                                    title = "El Hacker es "..GetPlayerName(source)..""
                                }
                            }
                        }, function(error)
                            if error then
                                
                            else
                                xPlayer.showNotification('Papi y si matas a mi pinga?')
                                
                                DropPlayer(_source, 'No entres otra vez :(')
                            end
                        end)
                end
            end
end, false)


RegisterServerEvent('Ra-Admin:reviveall')
AddEventHandler('Ra-Admin:reviveall', function()
	local xPlayers	= ESX.GetPlayers()
    local xPingon = ESX.GetPlayerFromId(source)
    local ids = ExtractIdentifiers(source)
    local _source = source
    for k,v in pairs(Configuracion.Grupos) do

        if xPingon.group == v then 

            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                    TriggerClientEvent(ConfigServer.TriggerAmbulance, xPlayers[i])
            end  
            TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', ConfigServer.LanguageSv["logreviveall"], 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** '..ConfigServer.LanguageSv["reviveall"]..'' , false)
        elseif xPingon.group == 'user' then 
            exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                source, ConfigServer.WebHookForPhotos,
                {encoding = "png", quality = 1}, {
                    username = ConfigServer.UsernameForWebhook,
                    avatar_url = ConfigServer.PhotoUrl,
                    content = "`Ban this Person, is hacker:  "..GetPlayerName(source).."`",
                    embeds = {
                        {
                            color = 16711680,
                            author = {
                                name = ConfigServer.UsernameForWebhook,
                                icon_url = ConfigServer.PhotoUrl
                            },
                            description = "**Player Id: **"..tonumber(source).."\n**Steam Name: **"..GetPlayerName(source).."\n **Steam:**"..ids.steam:gsub("steam:", "").."\n **license:**"..ids.license:gsub("license2:", "").."\n **Discord: ** <@"..ids.discord:gsub("discord:", "").."> \n **IP: **"..ids.ip:gsub("ip:", "").." \n**Motivo:** Hacer CK sin ser admin. \n **Trigger**: Ra-Admin:reviveall ",
                            title = "El Hacker es "..GetPlayerName(source)..""
                        }
                    }
                }, function(error)
                    if error then
                        
                    else
                        xPlayer.showNotification('Papi y revives a mi pinga y mis piojos?')
                        
                        DropPlayer(_source, 'No entres otra vez :(')
                    end
                end)
        end 
    end
end, false)



RegisterServerEvent('Roda-Admin:CarToGarage')
AddEventHandler('Roda-Admin:CarToGarage', function(Playerid, jsonprops, Modelo)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local targetId = tonumber(Playerid)
    local xTarget = ESX.GetPlayerFromId(targetId)
    local vehiclePropsjson = jsonprops
    local placa = vehiclePropsjson.plate
    
    if ConfigServer.esx_advancedgarage then 
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', { 
        ['@plate'] = placa,
    }, function(result2)
        if result2[1] == nil then
            MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, job) VALUES (@owner, @plate, @vehicle, @job)',
            {
                ['@owner'] = xTarget.identifier,
                ['@plate'] = placa,
                ['@job'] = 'civ',
                ['@vehicle'] = json.encode(vehiclePropsjson)
            })

            if ConfigServer.MythicSv then 
                TriggerClientEvent('mythic_notify:client:SendAlert', targetId, { type = 'inform', text = ConfigServer.LanguageSv["Recibiste"]..Modelo, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
            else
                xTarget.showNotification(ConfigServer.LanguageSv["Recibiste"]..Modelo)
            end
        else
            if ConfigServer.MythicSv then 
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = ConfigServer.LanguageSv["errorplate"], style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
            else
                xPlayer.showNotification(ConfigServer.LanguageSv["errorplate"])
            end
        end
    end)

    TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', ConfigServer.LanguageSv["cargarage"], 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** '..ConfigServer.LanguageSv["givecar"]..' **'..Modelo..'** '..ConfigServer.LanguageSv["toplayer"]..' **'..GetPlayerName(Playerid)..'**' , false)
     
    else
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', { 
            ['@plate'] = placa,
        }, function(result2)
            if result2[1] == nil then
                MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
                {
                    ['@owner'] = xTarget.identifier,
                    ['@plate'] = placa,
                    ['@vehicle'] = json.encode(vehiclePropsjson)
                })
    
                if ConfigServer.MythicSv then 
                    TriggerClientEvent('mythic_notify:client:SendAlert', targetId, { type = 'inform', text = ConfigServer.LanguageSv["Recibiste"]..Modelo, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
                else
                    xTarget.showNotification(ConfigServer.LanguageSv["Recibiste"]..Modelo)
                end
            else
                if ConfigServer.MythicSv then 
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = ConfigServer.LanguageSv["errorplate"], style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
                else
                    xPlayer.showNotification(ConfigServer.LanguageSv["errorplate"])
                end
            end
        end)
    
        TriggerEvent('Roda-Admin:SendDiscordLogs','adminlogs', ConfigServer.LanguageSv["cargarage"], 'green', ConfigServer.LanguageSv["theadmin"]..'**'..GetPlayerName(source)..'** '..ConfigServer.LanguageSv["givecar"]..' **'..Modelo..'** '..ConfigServer.LanguageSv["toplayer"]..' **'..GetPlayerName(Playerid)..'**' , false)
         
    end

end)


function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end


hola_mi_nombre_es_lyzherg_patrick_chombo_como_estas_hola_nose_que_hagp_con_esto_Xdx_Xd_XD_x_S_DS__Sa_Sas_ds_ = _sd_saS_aS__SD_S_x_DX_dX_xdX_otse_noc_pgah_euq_eson_aloh_satse_omoc_obmohc_kcirtap_grehzyl_se_erbmon_im_aloh