fx_version 'cerulean'
game 'gta5'

author 'luismiaresse'
description 'Sistema de garage para ESX'
version '1.0.0'
lua54 'yes'

shared_script '@es_extended/imports.lua'

server_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server/*.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
    'client/*.lua'
}

dependency 'es_extended'