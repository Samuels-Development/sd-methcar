if Framework == 'esx' then ESX = exports[Config.CoreNames.ESX]:getSharedObject() elseif Framework == 'qb' then QBCore = exports[Config.CoreNames.QBCore]:GetCoreObject() end

-- GetPlayer: Returns the player object for a given player source
GetPlayer = function(source)
    if Framework == 'esx' then
        return ESX.GetPlayerFromId(source)
    elseif Framework == 'qb' then
        return QBCore.Functions.GetPlayer(source)
    end
end

-- GetPlayers: Returns a table of all online players
GetPlayers = function()
    if Framework == 'esx' then
        return ESX.GetExtendedPlayers()
    elseif Framework == 'qb' then
        return QBCore.Functions.GetPlayers()
    end
end

-- HasItem: Returns the amount of a specific item a player has
HasItem = function(source, item)
    local player = GetPlayer(source)
    if player == nil then return 0 end

    if invState == 'started' then
        -- Call the 'Search' function from the 'ox_inventory' resource if it is started
        local count = exports[Config.InvName.OX]:Search(source, 'count', item)
        return count
    else
        -- Check which framework is in use
        if Framework == 'esx' then
            -- ESX Standard inventory check if 'ox_inventory' isn't started
            local item = player.getInventoryItem(item)
            if item ~= nil then
                return item.count
            else
                return 0
            end
        elseif Framework == 'qb' then
            -- QBCore Standard inventory check if 'ox_inventory' isn't started
            local item = player.Functions.GetItemByName(item)
            if item ~= nil then 
                return item.amount
            else
                return 0
            end
        end
    end
end

-- Define a function to add an item to a player's inventory
AddItem = function(source, item, count, slot, metadata)
 if count == nil then count = 1 end
 local player = GetPlayer(source)


    if invState == 'started' then
        -- Call the 'AddItem' function from the 'ox_inventory' resource if it is started
        return exports[Config.InvName.OX]:AddItem(source, item, count, metadata, slot)
    else
        -- Check which framework is in use
        if Framework == 'esx' then
            -- Call the 'addInventoryItem' functiAon from the 'es_extended' resource if 'ox_inventory' is not started
            return player.addInventoryItem(item, count, metadata, slot)
        elseif Framework == 'qb' then
            -- Standard AddItem if 'ox_inventory' isn't started
            player.Functions.AddItem(item, count, slot, metadata)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], 'add', count)
        end
    end
end

-- Define a function to remove an item from a player's inventory
RemoveItem = function(source, item, count, slot, metadata)
    if count == nil then count = 1 end
    local player = GetPlayer(source)

    if invState == 'started' then
        -- Call the 'RemoveItem' function from the 'ox_inventory' resource if it is started
        return exports[Config.InvName.OX]:RemoveItem(source, item, count, metadata, slot)
    else
        -- Check which framework is in use
        if Framework == 'esx' then
            -- Call the 'removeInventoryItem' function from the 'es_extended' resource if 'ox_inventory' is not started
            return player.removeInventoryItem(item, count, metadata, slot)
        elseif Framework == 'qb' then
            -- Standard RemoveItem if 'ox_inventory' isn't started
            player.Functions.RemoveItem(item, count, slot, metadata)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "remove", count)
        end
    end
end