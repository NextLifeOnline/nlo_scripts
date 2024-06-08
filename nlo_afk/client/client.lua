AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    RegisterPoints()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    
    RegisterPoints()
end)
  