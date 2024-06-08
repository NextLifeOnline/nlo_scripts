local isFarming = false

function RegisterPoints()
    for k, v in pairs(Config.AFK) do
        for lk, lv in pairs(v) do
            for cv = 1, #v.coords, 1 do
                local point = lib.points.new({
                    coords = v.coords[cv],
                    distance = v.radius,
                })

                function point:onEnter()
                    lib.showTextUI("[E] - " .. v.label)
                end
                
                function point:onExit()
                    lib.hideTextUI()
                end
                
                function point:nearby()
                    if self.currentDistance < 2 and IsControlJustReleased(0, 38) then
                        doAFKfarm(v, cv)
                    end
                end
            end
        end
    end
end

function doAFKfarm(v, index) 
    local canFarm = lib.callback.await('nlo_afk:canFarm', false, v, index)

    if not canFarm and not isFarming then
        local reason = lib.callback.await('nlo_afk:cantFarm', false, v, index)

        lib.notify({
            title = 'Farming',
            description = reason,
            type = 'error'
        })

        return
    end

    Citizen.CreateThread(function()
        while canFarm do
            canFarm = lib.callback.await('nlo_afk:canFarm', false, v, index)

            if canFarm then
                TriggerServerEvent("nlo_afk:doFarm", v, index)
            else
                isFarming = false
                break
            end

            Citizen.Wait(v.dur)
        end
    end)

    Citizen.CreateThread(function()
        while canFarm do
            Citizen.Wait(0)

            showHelp("[X] zum Stoppen")

            DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump

            if IsControlJustReleased(0, 73) then
                isFarming = false
                canFarm = false
                break
            end
        end
    end)
end

showHelp = function(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end