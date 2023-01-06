fx_version 'adamant'
author 'Roderic'
description 'Admin Menu for ESX'
game 'gta5'


resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

shared_script '@es_extended/imports.lua'

client_script {
    'Client/*.lua',
    'ConfigGrups.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'Server/server.lua',
    'Server/Configserver.lua',
    'ConfigGrups.lua',
    'Server/Serverlogs.lua'
}


ui_page 'html/index.html'


files {
	'html/index.html',
	'html/jquery.js',
	'html/init.js',
}


