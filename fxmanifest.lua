fx_version 'cerulean'
game { 'gta5' }

description 'qb-meth'
version '1.0.0'

client_scripts {
    'bridge/cl_bridge.lua',
	'client/main.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/sh_config.lua',
}

server_scripts {
    'bridge/sv_bridge.lua',
	'server/main.lua',
}

lua54 'yes'