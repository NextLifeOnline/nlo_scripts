function Ban(source, reason)
    exports.qbx_core:ExploitBan(source, reason)
end

function hasItem(source, item)
    local item = exports.ox_inventory:GetItem(source, item, nil, true)
    if item >= 1 then
        return true, item
    else
        return false, item

    end
end