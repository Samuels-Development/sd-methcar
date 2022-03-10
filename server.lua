local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-methcar:start')
AddEventHandler('qb-methcar:start', function()
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local ItemAcetone = Player.Functions.GetItemByName("acetone")
    local ItemLithium = Player.Functions.GetItemByName("lithium")
	local ItemMethlab = Player.Functions.GetItemByName("methlab")
	if ItemAcetone ~= nil and ItemLithium ~= nil and ItemMethlab ~= nil then
		if ItemAcetone.amount >= 5 and ItemLithium.amount >= 2 and ItemMethlab.amount >= 1 then	
			TriggerClientEvent("qb-methcar:startprod", _source)
			Player.Functions.RemoveItem("acetone", 5, false)
			Player.Functions.RemoveItem("lithium", 2, false)
		else
		TriggerClientEvent('qb-methcar:stop', _source)
		TriggerClientEvent('QBCore:Notify', source, "U don't have enough ingredients to cook!", 'error')
		end
	else
	TriggerClientEvent('qb-methcar:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing essential ingredients!", 'error')
	end
end)

RegisterServerEvent('qb-methcar:make')
AddEventHandler('qb-methcar:make', function(posx,posy,posz)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	if xPlayer.Functions.GetItemByName('methlab') ~= nil then
		if xPlayer.Functions.GetItemByName('methlab').amount >= 1 then	
			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('qb-methcar:smoke',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('qb-methcar:stop', _source)
		end
	else
	TriggerClientEvent('QBCore:Notify', source, "You're missing a lab!", 'error')
	end
end)

RegisterServerEvent('qb-methcar:finish')
AddEventHandler('qb-methcar:finish', function(qualtiy)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	local rnd = math.random(-5, 5)
	local amount = math.floor(qualtiy / 2) + rnd
	xPlayer.Functions.AddItem('meth', amount)
	TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items['meth'], "add", amount)
end)

RegisterServerEvent('qb-methcar:blow')
AddEventHandler('qb-methcar:blow', function(posx, posy, posz)
	local _source = source
	local xPlayers = QBCore.Functions.GetPlayers()
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('qb-methcar:blowup', xPlayers[i],posx, posy, posz)
	end
	xPlayer.Functions.RemoveItem('methlab', 1)
end)

