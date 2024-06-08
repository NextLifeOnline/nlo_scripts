local RegisteredTargets = {}

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    OnJobUpdate(QBX.PlayerData.job)
end)  

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    OnJobUpdate(QBX.PlayerData.Job)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job) 
    OnJobUpdate(Job)
end)

