# qb-methcar

# Doesn't include the shop ped featured in the preview video.

- [Preview](https://www.youtube.com/watch?v=DxdVkQSX17I)

## Dependencies
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-target](https://github.com/BerkieBb/qb-target)
- [qb-inventory](https://github.com/qbcore-framework/qb-inventory) *or* as showcased in the video lj-inventory!

Thanks for showing your personal interest in my work! 
Please consider supporting ❤

🔗 > https://discord.gg/Tu94MCDDEa
🔗 > https://samuels-development.dev/

## Installation
### Manually
1. Place the qb-methcar folder anywhere into your resources folder and ensure/start it in your server/resources.cfg

2. Add these items to your qb-core/shared/items.lua
#

	["acetone"] 				 	 = {["name"] = "acetone", 			  			["label"] = "Acetone", 					["weight"] = 5000, 		["type"] = "item", 		["image"] = "acetone.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "It is a colourless, highly volatile and flammable liquid with a characteristic pungent odour."},
  
	["methlab"] 				 	 = {["name"] = "methlab", 			  			["label"] = "Lab", 						["weight"] = 15000, 	["type"] = "item", 		["image"] = "lab.png", 					["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A portable Meth Lab"},
  
	["lithium"] 				 	 = {["name"] = "lithium", 			  			["label"] = "Lithium", 					["weight"] = 1000, 		["type"] = "item", 		["image"] = "lithium.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Lithium, something you can make Meth with!"},

3. Add the images contained in the file to your html/images of your respective inventory system!

4. Go to your qb-target/init.lua and add this to your Config.GlobalVehicleOptions
#
```
Config.GlobalVehicleOptions = {
    options = {
        {
            type = 'client',
            event = 'qb-methcar:cook',
            icon = 'fas fa-blender',
            label = 'Lets cook!',
			canInteract = function(entity)
                if GetVehicleEngineHealth(entity) <= 0 then return false end
                	local model = GetEntityModel(entity)
					local modelName = GetDisplayNameFromVehicleModel(model)
					if modelName == 'JOURNEY' then
                    return true
                end
                return false
            end
        },
    },
    distance = 2.0,
}
```

5. Done! :)
