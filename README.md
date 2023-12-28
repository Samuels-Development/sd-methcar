# sd-methcar

This was initially qb-methcar, but has since been almost fully rewritten.

Feel free to star the repository and check out my store and discord @ Discord: https://discord.gg/samueldev & Store: https://fivem.samueldev.shop 
For support inquires please create a post in the support-forum channel on discord or create an issue here on Github.

## Dependencies
- [qb-core](https://github.com/qbcore-framework/qb-core) or [es_extended](https://github.com/esx-framework)
- ox_lib & ox_target


## Installation

1. Clone or download this resource.
2. Place it in the server's resource directory.
3. Add the resource to your server config, if needed.

### Configuration
All available configurations can be found in shared/sh_config.lua

### Items

	["acetone"] 				 	 = {["name"] = "acetone", 			  			["label"] = "Acetone", 					["weight"] = 5000, 		["type"] = "item", 		["image"] = "acetone.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "It is a colourless, highly volatile and flammable liquid with a characteristic pungent odour."},
	["methlab"] 				 	 = {["name"] = "methlab", 			  			["label"] = "Lab", 						["weight"] = 15000, 	["type"] = "item", 		["image"] = "lab.png", 					["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A portable Meth Lab"},
	["lithium"] 				 	 = {["name"] = "lithium", 			  			["label"] = "Lithium", 					["weight"] = 1000, 		["type"] = "item", 		["image"] = "lithium.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Lithium, something you can make Meth with!"},

