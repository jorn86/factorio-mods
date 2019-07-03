local printMachines = function()
    for k, v in pairs(data.raw) do
        --print(k)
        if (k == "assembling-machine" or k == "mining-drill" or k == "furnace" or k == "lab") then
            print(k)
            for name,m in pairs(v) do
                print("  " .. name)
            end
        end
    end
    print("")
end
--printMachines()

local factories = require("scripts.findFactories")(mods)
require("prototypes.loader")
local all_big_entities = require("prototypes.prototypes")(factories)
data.raw["selection-tool"]["bf-loader-tool"].entity_filters = all_big_entities

if (settings.startup["bf-centrifuge-in-assembler"].value) then
    local machine = data.raw["assembling-machine"]["bf-assembling-machine-6"] or data.raw["assembling-machine"]["bf-assembling-machine-3"]
    if machine then table.insert(machine.crafting_categories, "centrifuging") end
end
