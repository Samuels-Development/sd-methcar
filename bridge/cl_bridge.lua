if Framework == 'esx' then ESX = exports[Config.CoreNames.ESX]:getSharedObject() elseif Framework == 'qb' then QBCore = exports[Config.CoreNames.QBCore]:GetCoreObject() end

-- Function to display a notification
ShowNotification = function(message, type)
    -- Check if the ox_lib (library) is available
   if lib ~= nil then
       -- Display notification using ox_lib
       lib.notify({
           description = message or false,
           id = id or false,
           position = 'top-right',
           icon = icon or false,
           duration = 3500,
           type = type
       })
   else
       -- Display notification using the respective framework's method if ox_lib isn't imported.
       if Framework == 'esx' then
           ESX.ShowNotification(message)
       elseif Framework == 'qb' then
           QBCore.Functions.Notify(message, type)
       end
   end
end

-- Event to show a notification to the player
RegisterNetEvent('sd-methcar:notification', function(msg, type)
    ShowNotification(msg, type)
end)

GetClosestVehicle = function(coords)
    local ped = PlayerPedId()
    local vehicles = GetGamePool('CVehicle')
    local closestDistance = -1
    local closestVehicle = -1
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    for i = 1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = #(vehicleCoords - coords)

        if closestDistance == -1 or closestDistance > distance then
            closestVehicle = vehicles[i]
            closestDistance = distance
        end
    end
    return closestVehicle, closestDistance
end