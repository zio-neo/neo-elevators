fx_version   'cerulean'
lua54        'yes'
games        { 'gta5' }

name         'neo-elevators'
author       'ZioNeo'
version      '1.0.0'
license      'LGPL-3.0'
repository   'not avaible'
description  'Elevators Script.'

--[[ Manifest ]]--
dependencies {
	'/server:5848',
    '/onesync',
}

shared_scripts {
    'sh_*.lua'
}

client_scripts {
    'client/cl_*.lua'
}
