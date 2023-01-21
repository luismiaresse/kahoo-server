
fx_version "adamant"
game "gta5"

author 'luismiaresse'
description 'Sistema de grúa para ESX'

shared_script '@es_extended/imports.lua'

server_scripts {
    'server.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
    '@oxmysql/lib/MySQL.lua',
}

client_scripts {
    'client.lua',
    'entityiter.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
}
