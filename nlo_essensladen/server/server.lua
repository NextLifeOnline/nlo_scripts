lib.callback.register('nlo_essensladen:checkItems', function(source, cb, v) 
    local gotItems = true

    for k, cv in pairs(v.requireditems) do
        print(cv.name, cv.amount, source)
        local hasItem = GetItem(cv.name, cv.amount, source)

        if not hasItem then
            gotItems = false
            break
        end
    end

    cb(not gotItems)
end)

lib.callback.register('nlo_essensladen:makeFood', function(source, cb, v)
    local gotItems = true

    for k, cv in pairs(v.requireditems) do
        local hasItem = GetItem(cv.name, cv.amount, source)

        if not hasItem then
            gotItems = false

            cb(gotItems)

            return
        end
    end

    Citizen.SetTimeout(v.duration, MadeItem(v, source))

    cb(gotItems)
end)