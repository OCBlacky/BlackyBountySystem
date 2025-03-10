local QBCore = exports['qb-core']:GetCoreObject()

local isMySQLAvailable = pcall(function() MySQL.ready() end)
local bountyFilePath = 'bounties.json'

local function loadBounties()
    if isMySQLAvailable then
        local result = MySQL.Sync.fetchAll('SELECT * FROM bounties WHERE status = "active"')
        return result
    else
        local file = LoadResourceFile(GetCurrentResourceName(), bountyFilePath)
        if file then
            return json.decode(file)
        else
            return {}
        end
    end
end

local function saveBounties(bounties)
    if isMySQLAvailable then
        for _, bounty in ipairs(bounties) do
            MySQL.Sync.execute('INSERT INTO bounties (target_name, target_id, reward, status, created_at) VALUES (@target_name, @target_id, @reward, @status, @created_at)', {
                ['@target_name'] = bounty.target_name,
                ['@target_id'] = bounty.target_id,
                ['@reward'] = bounty.reward,
                ['@status'] = bounty.status,
                ['@created_at'] = bounty.created_at
            })
        end
    else
        local data = json.encode(bounties)
        SaveResourceFile(GetCurrentResourceName(), bountyFilePath, data, -1)
    end
end

RegisterCommand("createbounty", function(source, args)
    local targetId = tonumber(args[1])
    local reward = tonumber(args[2])
    local targetName = GetPlayerName(targetId)

    local bounties = loadBounties()

    local newBounty = {
        target_name = targetName,
        target_id = targetId,
        reward = reward,
        status = 'active',
        created_at = os.date("%Y-%m-%d %H:%M:%S"),
        hunter_id = nil,
        hunter_name = nil
    }

    table.insert(bounties, newBounty)

    saveBounties(bounties)

    TriggerClientEvent("qb-phone:sendMessage", source, {
        subject = "Bounty Created",
        message = "You have created a bounty on " .. targetName .. " for $" .. reward,
    })
end)

RegisterCommand("listbounties", function(source)
    local bounties = loadBounties()

    local message = "Active Bounties:\n"
    for _, bounty in ipairs(bounties) do
        message = message .. "Target: " .. bounty.target_name .. " - Reward: $" .. bounty.reward .. "\n"
    end

    TriggerClientEvent("qb-phone:sendMessage", source, {
        subject = "Bounty List",
        message = message,
    })
end)

RegisterCommand("acceptbounty", function(source, args)
    local targetName = args[1]
    local bounties = loadBounties()

    for _, bounty in ipairs(bounties) do
        if bounty.target_name == targetName and bounty.status == 'active' then
            bounty.status = 'completed'
            bounty.hunter_id = source
            bounty.hunter_name = GetPlayerName(source)

            saveBounties(bounties)

            TriggerClientEvent("qb-phone:sendMessage", source, {
                subject = "Bounty Accepted",
                message = "You have accepted the bounty on " .. targetName .. ".",
            })

            return
        end
    end

    TriggerClientEvent("qb-phone:sendMessage", source, {
        subject = "Bounty Not Found",
        message = "No active bounty found for " .. targetName,
    })
end)
