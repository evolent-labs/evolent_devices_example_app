local OsApp = require '@evolent_devices.sdk.app'

local APP = 'hello'

AddEventHandler('evolent_devices:appOpened', function(app)
    if app ~= APP then return end

    exports.evolent_devices:sendAppMessage(APP, { action = 'greet', data = { name = GetPlayerName(cache.playerId) } })
end)

OsApp.handle(APP, 'roll', function()
    return lib.callback.await('hello:roll', false)
end)
