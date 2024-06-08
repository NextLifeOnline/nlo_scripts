function RegisterTargets(data)
    for lk, lv in pairs(data) do
        for cv = 1, #lv.coords, 1 do
            RegisteredTargets[#RegisteredTargets + 1] = exports.ox_target:addBoxZone({
                coords = lv.coords[cv],
                size = vector3(lv.radius,lv.radius,lv.radius),

                options = {
                    {
                        label = lv.label,
                        icon = lv.icon,
                        onSelect = function() 
                            Target(lv)
                        end
                    }
                }
            })
        end
    end
end

function Target(lv)
    options = {}

    for k, v in pairs(lv.items) do
        options[#options + 1] = {
            title = v.title,
            description = v.description,
            onSelect = function()
                lib.callback('nlo_essensladen:makeFood', false, function(DoFood)
                    if DoFood then
                        lib.progressBar({
                            duration = v.duration,
                            label = v.progressbar,
                            useWhileDead = false,
                        })
                    else
                        lib.notify({
                            title = "Essen",
                            description = 'Nicht genug für ' .. v.title,
                            type = 'error'
                        })
                    end
                end, v)
            end
        }
    end

    lib.registerContext({
        id = 'nlo_essensladen:menu',
        title = "Essen herstellen",
        options = options
    })

    lib.showContext("nlo_essensladen:menu")
end

function OnJobUpdate(job)
    for i = 1, #RegisteredTargets do
        exports.ox_target:removeZone(RegisteredTargets[i])
    end

    for k, v in pairs(Config.Locations) do
        if k == job.name then
            RegisterTargets(v)
        end
    end
end