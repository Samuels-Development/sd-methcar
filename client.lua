local QBCore = exports['qb-core']:GetCoreObject()

local started = false
local progress = 0
local pause = false
local quality = 0

RegisterNetEvent('qb-methcar:stop')
AddEventHandler('qb-methcar:stop', function()
	LastVehicle = QBCore.Functions.GetClosestVehicle()
	started = false
	progress = 0
	QBCore.Functions.Notify("Production stopped...", "error")
	FreezeEntityPosition(LastVehicle, false)
end)

RegisterNetEvent('qb-methcar:notify')
AddEventHandler('qb-methcar:notify', function(message)
	QBCore.Functions.Notify(message)
end)

RegisterNetEvent('qb-methcar:startprod')
AddEventHandler('qb-methcar:startprod', function()
	CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId(-1))
	started = true
	pause = false
	FreezeEntityPosition(CurrentVehicle, true)
	QBCore.Functions.Notify("Production started", "success")
end)

RegisterNetEvent('qb-methcar:smoke')
AddEventHandler('qb-methcar:smoke', function(posx, posy, posz, bool)
	if bool == 'a' then
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_bzgas_smoke", posx, posy, posz + 1.6, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.9)
		Citizen.Wait(60000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end
end)

-------------------------------------------------------EVENTS NEGATIVE
RegisterNetEvent('qb-methcar:boom', function()
	playerPed = (PlayerPedId())
	local pos = GetEntityCoords((PlayerPedId()))
	pause = false
	Citizen.Wait(500)
	started = false
	Citizen.Wait(500)
	CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId(-1))
	TriggerServerEvent('qb-methcar:blow', pos.x, pos.y, pos.z)
	TriggerEvent('qb-methcar:stop')
end)

RegisterNetEvent('qb-methcar:blowup')
AddEventHandler('qb-methcar:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2, 15, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(6000)
	StopParticleFxLooped(fire, 0)	
end)

RegisterNetEvent('qb-methcar:drugged')
AddEventHandler('qb-methcar:drugged', function()
	local pos = GetEntityCoords((PlayerPedId()))
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur((PlayerPedId()), true)
	SetPedMovementClipset((PlayerPedId()), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk((PlayerPedId()), true)
	quality = quality - 3
	pause = false
	Citizen.Wait(90000)
	ClearTimecycleModifier()
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('qb-methcar:q-1police', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 1
	pause = false
	TriggerServerEvent('police:server:policeAlert', 'Person reports stange smell!')
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('qb-methcar:q-1', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 1
	pause = false
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('qb-methcar:q-3', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 3
	pause = false
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('qb-methcar:q-5', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 5
	pause = false
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

-------------------------------------------------------EVENTS POSITIVE
RegisterNetEvent('qb-methcar:q2', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 2
	pause = false
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('qb-methcar:q3', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 3
	pause = false
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('qb-methcar:q5', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 5
	pause = false
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('qb-methcar:gasmask', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	SetPedPropIndex(playerPed, 1, 26, 7, true)
	quality = quality + 2
	pause = false
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('qb-methcar:cook', function()
	local pos = GetEntityCoords((PlayerPedId()))
	playerPed = (PlayerPedId())
	local CurrentVehicle = QBCore.Functions.GetClosestVehicle()
	if IsVehicleSeatFree(CurrentVehicle, 3) and IsVehicleSeatFree(CurrentVehicle, -1) and IsVehicleSeatFree(CurrentVehicle, 0) and IsVehicleSeatFree(CurrentVehicle, 1)and IsVehicleSeatFree(CurrentVehicle, 2) then
		TaskWarpPedIntoVehicle(PlayerPedId(), CurrentVehicle, 3)
		SetVehicleDoorOpen(CurrentVehicle, 2)
		Wait(300)
		TriggerServerEvent('qb-methcar:start')
		TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
		Wait(1000)
		quality = 0
	else
		QBCore.Functions.Notify('There is someone in your kitchen?!', "error")
	end
end)

---------EVENTS------------------------------------------------------

RegisterNetEvent('qb-methcar:proses', function()
	--
	--   EVENT 1
	--
	if progress > 9 and progress < 11 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Gas tank is leaking... now what?",
				txt = "Pick your answer below. Progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Fix with tape",
				params = {
					event = "qb-methcar:q-3",
					args = {
						message = "That kinda fixed it, I suppose?!"
					}
				}
			},
			{
				header = "🔴 Let it go!",
				params = {
					event = "qb-methcar:boom"
				}
			},
			{
				header = "🔴 Replace tube",
				params = {
					event = "qb-methcar:q5",
					args = {
						message = "Replacing it was the best solution!"
					}
				}
			},
		})
	end
	--
	--   EVENT 2
	--
	if progress > 19 and progress < 21 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "You spilled some acetone on the floor.. now what?",
				txt = "Pick your answer below. Progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Open a window",
				params = {
					event = "qb-methcar:q-1police",
					args = {
						message = "The pungent smell is attracting people!"
					}
				}
			},
			{
				header = "🔴 Breathe it in..",
				params = {
					event = "qb-methcar:drugged"
				}
			},
			{
				header = "🔴 Put on a gas mask",
				params = {
					event = "qb-methcar:gasmask",
					args = {
						message = "Wise Choice"
					}
				}
			},
		})
	end
	--
	--   EVENT 3
	--
	if progress > 29 and progress < 31 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Meth is being produced too quickly, what do you do?",
				txt = "Pick your answer below. Progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Add more temperature",
				params = {
					event = "qb-methcar:q5",
					args = {
						message = "A higher temperture made the perfect balance!"
					}
				}
			},
			{
				header = "🔴 Add more pressure",
				params = {
					event = "qb-methcar:q-3",
					args = {
						message = "The pressure fluctuated a lot.."
					}
				}
			},
			{
				header = "🔴 Lower the pressure",
				params = {
					event = "qb-methcar:q-5",
					args = {
						message = "That was the worst thing to do!"
					}
				}
			},
		})
	end
	--
	--   EVENT 4
	--
	if progress > 39 and progress < 41 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "You added to much acetone, what to do?",
				txt = "Pick your answer below. Progres: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Do nothing..",
				params = {
					event = "qb-methcar:q-5",
					args = {
						message = "The Meth is smelling like pure acetone"
					}
				}
			},
			{
				header = "🔴 Use a straw to suck it out",
				params = {
					event = "qb-methcar:drugged"
				}
			},
			{
				header = "🔴 Add lithium to stabilize",
				params = {
					event = "qb-methcar:q5",
					args = {
						message = "Smart solution"
					}
				}
			},
		})
	end
	--
	--   EVENT 5
	--
	if progress > 49 and progress < 51 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "There is some blue pigment, use it?",
				txt = "Pick your answer below. Progres: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Add it in the mix!",
				params = {
					event = "qb-methcar:q5",
					args = {
						message = "Smart move, people like it!"
					}
				}
			},
			{
				header = "🔴 Put away",
				params = {
					event = "qb-methcar:q-1",
					args = {
						message = "Not very creative are you?"
					}
				}
			},
		})
	end
	--
	--   EVENT 6
	--
	if progress > 59 and progress < 61 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "The filter is filthy, now what?",
				txt = "Pick your answer below. Progres: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Blow it out with a compressor",
				params = {
					event = "qb-methcar:q-5",
					args = {
						message = "You made a mess of the product!"
					}
				}
			},
			{
				header = "🔴 Replace the filter!",
				params = {
					event = "qb-methcar:q5",
					args = {
						message = "Replacing was the best option!"
					}
				}
			},
			{
				header = "🔴 Clean it with a brush",
				params = {
					event = "qb-methcar:q-1",
					args = {
						message = "It helped but not enough"
					}
				}
			},
		})
	end
	--
	--   EVENT 7
	--
	if progress > 69 and progress < 71 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "You spilled some acetone on the floor.. now what?",
				txt = "Pick your answer below. Progres: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Breathe it in..",
				params = {
					event = "qb-methcar:drugged"
				}
			},
			{
				header = "🔴 Put on a gas mask",
				params = {
					event = "qb-methcar:gasmask",
					args = {
						message = "Good choice"
					}
				}
			},
			{
				header = "🔴 Open a window",
				params = {
					event = "qb-methcar:q-1police",
					args = {
						message = "The pungent smell is attracting more people!"
					}
				}
			},
		})
	end
	--
	--   EVENT 8
	--
	if progress > 79 and progress < 81 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Gas tank is leaking... now what?",
				txt = "Pick your answer below. Progres: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Let it go!",
				params = {
					event = "qb-methcar:boom"
				}
			},
			{
				header = "🔴 Fix it with tape",
				params = {
					event = "qb-methcar:q-3",
					args = {
						message = "That kinda fixed it, i think?!"
					}
				}
			},
			{
				header = "🔴 Replace tube",
				params = {
					event = "qb-methcar:q5",
					args = {
						message = "Replacing was the best solution!"
					}
				}
			},
		})
	end
	--
	--   EVENT 9
	--
	if progress > 89 and progress < 91 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "You really need to take a shit! What do you do?",
				txt = "Pick your answer below. Progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Just pinch it off!",
				params = {
					event = "qb-methcar:q5",
					args = {
						message = "Superb Job!"
					}
				}
			},
			{
				header = "🔴 Go outside to shit!",
				params = {
					event = "qb-methcar:q-1police",
					args = {
						message = "Somebody spotted you!"
					}
				}
			},
			{
				header = "🔴 Shit inside!",
				params = {
					event = "qb-methcar:q-5",
					args = {
						message = "Not good! Everything smells like SHIT!"
					}
				}
			},
		})
	end
	--
	--   DONE
	--	
	if progress > 99 and progress < 101 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Job all done 🎉",
				txt = "" .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Collect your meth!",
				params = {
					event = "qb-methcar:done",
					args = {
						message = ""
					}
				}
			}
		})
	end
end)

RegisterNetEvent('qb-methcar:done', function()
	quality = quality + 5
	started = false
	TriggerEvent('qb-methcar:stop')
	TriggerServerEvent('qb-methcar:finish', quality)
	SetPedPropIndex(playerPed, 1, 0, 0, true)
end)

-----THREADS------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(250)
		if started == true then
			if pause == false and IsPedInAnyVehicle(playerPed) then
				Citizen.Wait(250)
				progress = progress +  1
				quality = quality + 1
				QBCore.Functions.Notify('Meth production: ' .. progress .. '%')
				TriggerEvent('qb-methcar:proses')
				Citizen.Wait(2000)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if IsPedInAnyVehicle((PlayerPedId())) then
		else
			if started then
				playerPed = (PlayerPedId())
				CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId(-1))
				pause = true
				started = false
				TriggerEvent('qb-methcar:stop')
				SetPedPropIndex(playerPed, 1, 0, 0, true)
				FreezeEntityPosition(CurrentVehicle, false)
			end
		end
	end
end)




