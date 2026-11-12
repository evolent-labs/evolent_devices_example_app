fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

author 'Evolent Labs'
description 'Hello: the example app for the Evolent OS (evolent_devices)'
version '1.0.0'

shared_script '@ox_lib/init.lua'
server_script 'server.lua'
client_script 'client.lua'

files {
    'web/build/index.html',
    'web/build/assets/*',
    'web/build/fonts/*',
}
