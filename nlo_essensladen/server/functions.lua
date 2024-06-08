function GetItem(name, count, source)
    local src = source
    
    local item = exports.ox_inventory:Search(src, name, nil, false)

    if item.count >= count then
        return true
    else
        return false
    end
end

function AddItem(name, count, source)
    exports.ox_inventory:AddItem(source, name, count)
end

function RemoveItem(name, count, source)
    exports.ox_inventory:RemoveItem(source, name, count)
end

function MadeItem(v, source)
    for k, cv in pairs(v.requireditems) do
        RemoveItem(cv.name, cv.amount, source)
    end

    for k, cv in pairs(v.additems) do
        AddItem(cv.name, cv.amount, source)
    end
end