local APP = 'hello'

local function register()
    local ok, reason = exports.evolent_devices:registerApp({
        api = 1,
        id = APP,
        label = 'Hello',
        description = 'A small example app: rolls a number on the server.',
        version = '1.0.0',
        icon = { path = 'M12 2.5a9.5 9.5 0 1 0 0 19a9.5 9.5 0 1 0 0-19zM8.2 9.4a1.4 1.4 0 1 0 0 2.8a1.4 1.4 0 1 0 0-2.8zM15.8 9.4a1.4 1.4 0 1 0 0 2.8a1.4 1.4 0 1 0 0-2.8zM7.4 14.2c1 2.1 2.7 3.3 4.6 3.3s3.6-1.2 4.6-3.3z', color = '#C3FF00' },
        page = 'web/build/index.html',
        kinds = { 'pc', 'laptop', 'tablet' },
        canvas = { width = 960, height = 600 },
        watch = 'state',
        network = true,
        defaults = { kinds = { pc = true, laptop = true, tablet = true }, playerDevices = true },
        onOpen = function(source)
            return { greeting = ('Hello from the server, it is %s here.'):format(os.date('%H:%M')) }
        end,
        notices = function(source)
            return {
                {
                    id = 'welcome',
                    title = 'Hello is installed',
                    body = 'Open it from the desktop or the launcher.',
                    action = 'Open',
                },
            }
        end,
        watchData = function()
            return { title = 'Hello' }
        end,
    })

    if not ok then
        lib.print.warn(('not registered: %s'):format(reason))
    end
end

AddEventHandler('evolent_devices:ready', register)

CreateThread(function()
    if GetResourceState('evolent_devices') == 'started' then
        register()
    end
end)

lib.callback.register('hello:roll', function(source)
    if not exports.evolent_devices:appUser(source, APP) then
        return { ok = false, error = 'not_open' }
    end

    return { ok = true, data = { value = math.random(1, 100) } }
end)
