fx_version 'cerulean'
game 'gta5'

description 'tw_utils'
version '1.0.0'

shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}

client_script {
	'client/main.lua',
    'client/*.lua'
}

server_scripts {
    'server/*.lua',
}

files {
	'version'
}

lua54 'yes'
use_fxv2_oal 'yes'
