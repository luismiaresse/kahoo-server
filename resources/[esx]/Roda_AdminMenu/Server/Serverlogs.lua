
RegisterServerEvent('Roda-Admin:SendDiscordLogs')
AddEventHandler('Roda-Admin:SendDiscordLogs', function(name, title, color, message, tagEveryone, tagcontent )
    local tag = tagEveryone ~= nil and tagEveryone or false
    local webHook = ConfigServer.Webhooks[name] ~= nil and ConfigServer.Webhooks[name] or ConfigServer.Webhooks[name]

    local embedData = {
        {
            ["title"] = title,
            ["color"] = ConfigServer.Colors[color] ~= nil and ConfigServer.Colors[color] or ConfigServer.Colors[name],
            ["footer"] = {
                ["text"] = os.date("%c"),
            },
            ["description"] = message,
        }
    }

    PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = ConfigServer.UsernameForWebhook,embeds = embedData}), { ['Content-Type'] = 'application/json' })

    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = ConfigServer.UsernameForWebhook, content = tagcontent}), { ['Content-Type'] = 'application/json' })
    end
end)