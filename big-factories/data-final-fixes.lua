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

require("prototypes.loader")
require("prototypes.prototypes")

if (settings.startup["bf-centrifuge-in-assembler"].value) then
    local machine = data.raw["assembling-machine"]["bf-assembling-machine"]
    if machine then table.insert(machine.crafting_categories, "centrifuging") end
end
