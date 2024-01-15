RegisterNetEvent('sd-methcar:server:start', function()
	local src = source
	TriggerClientEvent("sd-methcar:client:startproduction", src)
end)

RegisterNetEvent("sd-methcar:server:startcook", function()
	local src = source
	local ItemAcetone = HasItem(src, "acetone")
    local ItemLithium = HasItem(src, "lithium")
	local ItemMethlab = HasItem(src, "methlab")
	if ItemAcetone ~= nil and ItemLithium ~= nil and ItemMethlab ~= nil then
		if ItemAcetone >= 5 and ItemLithium >= 2 and ItemMethlab >= 1 then
			RemoveItem(src, "acetone", 5, false)
			RemoveItem(src, "lithium", 2, false)
			TriggerClientEvent('sd-methcar:client:cook', src)
		else
			TriggerClientEvent('sd-methcar:client:stop', src)
			TriggerClientEvent('sd-methcar:notification', source, "You're missing essential ingredients!", 'error')
		end
		else
		TriggerClientEvent('sd-methcar:client:stop', src)
	end
end)

RegisterNetEvent('sd-methcar:server:make', function(posx,posy,posz)
	local src = source
	local Player = GetPlayer(tonumber(src))
	local ItemMethlab = HasItem(src, "methlab")
	if ItemMethlab ~= nil then
		if ItemMethlab >= 0 then	
			local Players = GetPlayers()
			for i=1, #Players, 1 do
				TriggerClientEvent('sd-methcar:client:smoke', Players[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('sd-methcar:client:stop', src)
		end
	else
	TriggerClientEvent('sd-methcar:notification', src, "You're missing a lab!", 'error')
	end
end)

RegisterNetEvent('sd-methcar:server:finish', function(quality)
	local src = source
	local rnd = math.random(-5, 5)
	local amount = math.floor(quality / 2) + rnd
	AddItem(src, 'meth', amount)
end)

RegisterNetEvent('sd-methcar:server:blow', function(posx, posy, posz)
	local src = source
	local Players = GetPlayers()
	local xPlayer = GetPlayer(tonumber(src))
	for i=1, #Players, 1 do
		TriggerClientEvent('sd-methcar:client:blowup', Players[i],posx, posy, posz)
	end
	RemoveItem(src, 'methlab', 1)
end)

