local minable = settings.startup["wsfx-minable"].value
local craftable = settings.startup["wsfx-craftable"].value
local slots = settings.startup["wsfx-module-slots"].value

local flags = {"placeable-neutral", "placeable-player", "player-creation"}
if not minable then table.insert(flags, "not-deconstructable") end
if not (minable or craftable) then table.insert(flags, "not-blueprintable") end

local function update(name)
    local item = data.raw.item[name]
    item.subgroup = "production-machine"
    item.order = "z[" .. name .. "]"

    local entity = data.raw["assembling-machine"][name]
    entity.module_specification.module_slots = slots
    entity.flags = flags
    entity.create_ghost_on_death = minable or craftable
    if minable then
        entity.minable = { mining_time = 2, result = name }
    end
end

update("wsf-big-assembly")
update("wsf-big-furnace")
update("wsf-big-refinery")
