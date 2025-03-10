fx_version 'cerulean'
game 'gta5'

author 'Blacky'
description 'Bounty Hunter System for QBcore'
version '1.0.0'

server_scripts {
    '@qb-core/shared/locale.lua',
    '@mysql-async/lib/MySQL.lua',
    'server.lua',
}

client_scripts {
    'client.lua',
}

dependency 'qb-core'
dependency 'mysql-async'
