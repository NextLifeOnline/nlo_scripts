fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'R3tr0Ananas'
description 'Script von R3tr0Ananas'
version '1.0.0'

files {}

server_scripts {
    "server/*.lua"
}

client_scripts {
    "client/*.lua"
}

shared_scripts {'@ox_lib/init.lua', '@qbx_core/modules/lib.lua', 'config.lua'}