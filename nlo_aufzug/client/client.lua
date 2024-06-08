for k, v in pairs(Config.Teleporter) do
    for pk, pv in pairs(v) do
        local Point = lib.points.new({
            coords = pv.Marker, 
            distance = Config.Distance
        })

        function Point:onEnter()
            if pv.InCar == false and IsPedInAnyVehicle(cache.ped, false) then
                return
            end
            
            lib.showTextUI('[E] - Aufzug')
        end
         
        function Point:onExit()
            lib.hideTextUI()
        end
         
        function Point:nearby()
            options = {}
            for pk, pv in pairs(v) do
                options[#options+1] =  {
                    title = pk,
                    onSelect = function()
                        Teleport(cache.ped, pv.Landing)
                    end,
                }
            end
    
            lib.registerContext({
                id = k,
                title = k,
                options = options
            })
            
            if pv.InCar == false and IsPedInAnyVehicle(cache.ped, false) then
                return
            end

            DrawMarker(2, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 200, 20, 20, 50, false, true, 2, false, nil, nil, false)
         
            if self.currentDistance < 5 and IsControlJustReleased(0, 38) then
                lib.showContext(k)
            end
        end
    end
end

function Teleport(ped, landing)
    if IsPedInAnyVehicle(cache.ped, false) then
        local vehicle = GetVehiclePedIsIn(cache.ped, false)
        FreezeEntityPosition(vehicle, true)
        SetEntityCollision(vehicle, false, false)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
    
        SetEntityCoordsNoOffset(vehicle, landing.x, landing.y, landing.z, false, false, false)
        FreezeEntityPosition(vehicle, false)
        SetEntityCollision(vehicle, true, true)
        ActivatePhysics(vehicle)
        Citizen.Wait(3000)
    
        DoScreenFadeIn(1000)
        Citizen.Wait(1000)
    else
        DoScreenFadeOut(Config.Fade)
        Citizen.Wait(Config.Fade)
        SetEntityCoords(cache.ped, landing)
        Citizen.Wait(Config.Fade)
        DoScreenFadeIn(Config.Fade)
    end
end