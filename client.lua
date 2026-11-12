local APP = 'hello'

AddEventHandler('evolent_devices:appOpened', function(app)
    if app ~= APP then return end

    exports.evolent_devices:sendAppMessage(APP, { action = 'greet', data = { name = GetPlayerName(cache.playerId) } })
end)

RegisterNUICallback('roll', function(data, cb)
    if not exports.evolent_devices:isAppPost(APP, data) then
        return cb({ ok = false })
    end

    cb(lib.callback.await('hello:roll', false))
end)

AddEventHandler('evolent_devices:appPost', function(app, name, data, replyId)
    if app ~= APP or name ~= 'roll' then return end

    exports.evolent_devices:answerAppPost(replyId, lib.callback.await('hello:roll', false))
end)
