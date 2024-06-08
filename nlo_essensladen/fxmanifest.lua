fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'R3tr0Ananas'
description 'Script von R3tr0Ananas'
version '1.0.0'

server_scripts {
    "server/*.lua",
}

client_scripts {
    "client/*.lua",
    "@qbx_core/modules/playerdata.lua"
}

shared_scripts {'@ox_lib/init.lua', 'config.lua'}