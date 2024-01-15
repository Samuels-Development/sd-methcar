local started = false
local progress = 0
local pause = false
local quality = 0
local failedAttempts = 0
local hasBeenDrugged = false
local policeAlerted = false

function policeAlert()

    -- Add your own Dispatch into this function.
    
    -- sd_lib util function, only works if sd_lib is imported.
    --[[
    SD.utils.PoliceDispatch({
        displayCode = "10-95",                   -- Suspicious vehicle/person report
        title = 'Meth Cooking',                       -- Title is used in cd_dispatch/ps-dispatch
        description = "Suspicious Journey Spotted", -- Description of the event
        message = "Potential drug making in progress", -- Additional message
        -- Blip information is used for ALL dispatches besides ps_dispatch, please reference dispatchcodename below.
        sprite = 51,                           -- The blip sprite for handoff or related icon
        scale = 1.0,                            -- The size of the blip
        colour = 1,                             -- Color of the blip
        blipText = "Meth Van",                   -- Text on the Blip
        -- ps-dispatch
        dispatchcodename = "meth_cook"            -- This is the name used by ps-dispatch users for the sv_dispatchcodes.lua or config.lua under the Config.Blips entry. (Depending on Version)
    })
    ]]
end 

RegisterNetEvent('sd-methcar:client:startproduction', function()
	CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId(-1))
	started = true
	pause = false
	FreezeEntityPosition(CurrentVehicle, true)
	ShowNotification("Production started", "success")
end)

RegisterNetEvent('sd-methcar:client:smoke', function(posx, posy, posz, bool)
	if bool == 'a' then
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_bzgas_smoke", posx, posy, posz + 1.6, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.9)
		Wait(60000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end
end)

RegisterNetEvent('sd-methcar:client:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2, 15, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
    Wait(6000)
	StopParticleFxLooped(fire, 0)	
end)

local drugged = function()
    local pos = GetEntityCoords((PlayerPedId()))
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur((PlayerPedId()), true)
	SetPedMovementClipset((PlayerPedId()), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk((PlayerPedId()), true)
	quality = quality - 3
	pause = false
	Wait(90000)
	ClearTimecycleModifier()
	TriggerServerEvent('sd-methcar:server:make', pos.x,pos.y,pos.z)
end

-- Logic for handling question selection
local handleQuestionSelect = function(correctAnswer)
    local pos = GetEntityCoords(PlayerPedId())
    pause = false

    if correctAnswer then
        quality = quality + math.random(2, 5)
        failedAttempts = 0 
    else
        quality = quality - math.random(1, 5)
        failedAttempts = failedAttempts + 1

        if not hasBeenDrugged and math.random(1, 100) <= 40 then
            drugged()
            hasBeenDrugged = true 
            return 
        end

        if not policeAlerted and math.random(1, 100) <= 20 then 
            policeAlert()
            policeAlerted = true 
        end

        if failedAttempts >= 3 then
            quality = 0
            TriggerEvent('sd-methcar:client:finish') 
            return 
        end
    end

    TriggerServerEvent('sd-methcar:server:make', pos.x, pos.y, pos.z)
end

-- Function to shuffle the questions within a set
local shuffleQuestions = function(questions)
    for i = #questions, 2, -1 do
        local j = math.random(i)
        questions[i], questions[j] = questions[j], questions[i]
    end
end

-- Create options for context menu based on question set
local createOptions = function(questionSet)
    -- Shuffle questions in the set
    shuffleQuestions(questionSet)

    local options = {}
    for i = 1, #questionSet do
        local q = questionSet[i]
        table.insert(options, {
            title = q.question,
            icon = 'fa-solid fa-comment',
            onSelect = function() handleQuestionSelect(q.correctAnswer) end
        })
    end
    return options
end

-- Handling each event with title
local handleEvent = function(eventId, questionSet)
    pause = true
    lib.registerContext({
        id = eventId,
        title = questionSet.title, 
        options = createOptions(questionSet)
    })
    lib.showContext(eventId)
end

-- Select a random set of three questions
local getRandomQuestionSet = function(progress)
    local progressQuestionSets = Config.Questions[progress]
    if not progressQuestionSets then return nil end

    local randomSetIndex = math.random(#progressQuestionSets)
    return progressQuestionSets[randomSetIndex]
end

-- Event(s) for starting and stopping/finishing the meth cooking.
RegisterNetEvent('sd-methcar:client:cook', function()
	local pos = GetEntityCoords((PlayerPedId()))
	playerPed = (PlayerPedId())
	local CurrentVehicle = GetClosestVehicle()
	if IsVehicleSeatFree(CurrentVehicle, 3) and IsVehicleSeatFree(CurrentVehicle, -1) and IsVehicleSeatFree(CurrentVehicle, 0) and IsVehicleSeatFree(CurrentVehicle, 1)and IsVehicleSeatFree(CurrentVehicle, 2) then
		TaskWarpPedIntoVehicle(PlayerPedId(), CurrentVehicle, 3) SetVehicleDoorOpen(CurrentVehicle, 2) Wait(300)
		TriggerServerEvent('sd-methcar:server:start')
		TriggerServerEvent('sd-methcar:server:make', pos.x,pos.y,pos.z)
		Wait(1000)
		quality = 0
	else
		ShowNotification('There is someone in your kitchen?!', "error")
	end
end)

RegisterNetEvent('sd-methcar:client:stop', function()
	local LastVehicle = GetClosestVehicle()
	started = false
	progress = 0
	ShowNotification("Production stopped...", "error")
	FreezeEntityPosition(LastVehicle, false)
end)

RegisterNetEvent('sd-methcar:client:process', function(progress)
    local questionSet = getRandomQuestionSet(progress)
    if questionSet then
        handleEvent('methcar_event_' .. tostring(progress), questionSet)
    end
end)

RegisterNetEvent('sd-methcar:client:finish', function()
	TriggerServerEvent('sd-methcar:server:finish', quality)
	SetPedPropIndex(playerPed, 1, 0, 0, true)
    started = false quality = 0 hasBeenDrugged = false policeAlerted = false TriggerEvent('sd-methcar:client:stop')
end)

CreateThread(function()
    while true do
        Wait(250)
        if started == true then
            if pause == false and IsPedInAnyVehicle(playerPed) then
                Wait(250)
                progress = progress + 1
                quality = quality + 1
                ShowNotification('Meth production: ' .. progress .. '%')

                -- Check if production has reached 100%
                if progress >= 100 then
                    -- Trigger the finish event
                    TriggerEvent('sd-methcar:client:finish')
                    break
                end

                if Config.Questions[progress] then
                    pause = true
                    local questionSet = getRandomQuestionSet(progress)
                    if questionSet then
                        handleEvent('methcar_event_' .. tostring(progress), questionSet)
                    end
                else
                    TriggerEvent('sd-methcar:client:process', progress) 
                end

                Wait(2000)
            end
        end
    end
end)

RegisterNetEvent('sd-methcar:client:startcook', function()
    TriggerServerEvent('sd-methcar:server:startcook')
end)

-- Adding target to the 'Journey'
CreateThread(function()
	local methCar = 'journey'

    exports.ox_target:addModel(methCar, {
        {
			event = 'sd-methcar:client:startcook',
            icon = 'fas fa-fire-burner',
            label = 'Start Cooking',
            distance = 1.5,
			items = 'methlab'
        }
    })

end)




