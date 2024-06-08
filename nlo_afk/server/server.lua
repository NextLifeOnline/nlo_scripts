local cooldown = {}

lib.callback.register('nlo_afk:canFarm', function(source, v, index)
    return AllowedToFarm(source, v, index)
end)

RegisterNetEvent("nlo_afk:doFarm")
AddEventHandler("nlo_afk:doFarm", function(v, index)
    local canFarm = true

    local coords = GetEntityCoords(GetPlayerPed(source))
    local distance = #(coords - v.coords[index])
    
    if distance == nil then
        Ban(source, "nlo_afk:doFarm exploit")

        return
    end

    if distance > 10 then
        Ban(source, "nlo_afk:doFarm exploit")

        return
    end

    if v.needItem.needs then
        local item = v.needItem.item

        local xItem, xCount = hasItem(source, item)

        if not xItem then
            Ban(source, "nlo_afk:doFarm exploit")

            return
        end
    end

    if v.process then
        local item = v.items.from

        local xItem, xCount = hasItem(source, item)

        if xItem then
            if not xCount >= v.items.form_amount then
                Ban(source, "nlo_afk:doFarm exploit")

                return
            end
        end
    end

    if v.process then
        local success = exports.ox_inventory:RemoveItem(source, v.items.from, v.items.form_amount)

        local success, response = exports.ox_inventory:AddItem(source, v.items.to, v.items.to_amount)
    else
        local success, response = exports.ox_inventory:AddItem(source, v.items[math.random( #v.items )].item, 1)
    end
end)

lib.callback.register('nlo_afk:cantFarm', function(source, v, index)
    local canFarm = true

    local coords = GetEntityCoords(GetPlayerPed(source))
    local distance = #(coords - v.coords[index])

    if distance == nil then
        return "Zu weit weg"
        
    end

    if distance > v.radius then
        return "Zu weit weg"
    end

    if v.needItem.needs then
        local item = v.needItem.item

        local xItem, xCount = hasItem(source, item)

        if not xItem then
            return "Du hast nicht " .. item
        end
    end

    if v.process then
        local xItem, xCount = hasItem(source, item)

        if xItem then
            if not xCount >= v.form_amount then
                return "Nicht genug " .. xItem.name
            end
        end
    end

    return ""
end)

function AllowedToFarm(source, v, index)
    local canFarm = true

    local coords = GetEntityCoords(GetPlayerPed(source))
    local distance = #(coords - v.coords[index])

    if distance == nil then
        canFarm = false
    end

    if distance > v.radius then
        canFarm = false
    end

    if v.needItem.needs then
        local item = v.needItem.item

        local xItem, xCount = hasItem(source, item)
        
        canFarm = xItem

    end

    if v.process then
        local xItem, xCount = hasItem(source, item)

        if xItem then
            if not xCount >= v.form_amount then
                canFarm = false
            end
        end
    end

    return canFarm
end