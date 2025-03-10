local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-phone:sendMessage', function(data)
    TriggerEvent('qb-phone:showNotification', data.subject, data.message)
end)
