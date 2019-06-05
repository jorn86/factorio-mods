local printMachines = function()
    for k, v in pairs(data.raw) do
        --print(k)
        if (k == 'assembling-machine' or k == 'mining-drill' or k == 'furnace' or k == 'lab') then
            print(k)
            for name,m in pairs(v) do
                print('  ' .. name)
            end
        end
    end
    print('')
end
--printMachines()

local findFactories = require('scripts.findFactories')
require('prototypes.loader')
require('prototypes.prototypes')(findFactories(mods))

if (settings.startup['bf-centrifuge-in-assembler'].value) then
    local machine = data.raw['assembling-machine']['bf-assembling-machine-6'] or data.raw['assembling-machine']['bf-assembling-machine-3']
    if machine then table.insert(machine.crafting_categories, 'centrifuging') end
end