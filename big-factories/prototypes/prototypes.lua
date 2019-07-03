require("util")
require("scripts.utility")
local adjustVisuals = require("scripts.adjustVisuals")

local sizeFactor = settings.startup["bf-size-factor"].value
local speedFactor = settings.startup["bf-speed-factor"].value
local minable = settings.startup["bf-minable"].value
local craftable = settings.startup["bf-craftable"].value
local moduleSlots = settings.startup["bf-module-slots"].value
local scaleIcon = settings.startup["bf-scale-icon"].value
local flags = {"placeable-neutral", "placeable-player", "player-creation"}
if not minable then table.insert(flags, "not-deconstructable") end
if not (minable or craftable) then table.insert(flags, "not-blueprintable") end

local bigName = function(itemOrEntity)
    if (itemOrEntity.localised_name) then
        return {"", "Big ", itemOrEntity.localised_name}
    else
        return {"", "Big ", {"entity-name." .. itemOrEntity.name}}
    end
end

local bigItem = function(item)
    local bigItem = util.table.deepcopy(item)
    bigItem.name = "bf-" .. item.name
    bigItem.localised_name = {"", "Big ", {"entity-name." .. item.name}}
    bigItem.place_result = bigItem.name
    bigItem.subgroup = "production-machine"
    bigItem.order = "z[" .. item.name .. "]"
    return bigItem
end

local bigTechnology = function(item)
    local originalTech = findTechThatUnlocks(item.name)
    local bigTech = {
        type = "technology",
        name = "bf-" .. item.name,
        localised_name = bigName(item),
        icon = originalTech.icon,
        icon_size = originalTech.icon_size,
        prerequisites = { "bf-construction" },
        effects = {{ type = "unlock-recipe", recipe = "bf-" .. item.name }},
        unit = {
            ingredients = {{"automation-science-pack", 1},{"logistic-science-pack", 1},{"chemical-science-pack", 1},{"production-science-pack", 1}},
            count = 500,
            time = 60
        }
    }
    local number = string.find(bigTech.name, "-%d+$")
    if number then
        bigTech.name = string.sub(bigTech.name, 0, number - 1)
    end
    if (originalTech.enabled ~= false) then
        table.insert(bigTech.prerequisites, originalTech.name)
    end
    return bigTech
end

local bigRecipe = function(item)
    local name = "bf-" .. item.name
    return {
        type = "recipe",
        name = name,
        localised_name = bigName(item),
        order = "zbf[" .. name .. "]",
        energy_required = 1,
        enabled = false,
        ingredients =
        {
            {type = "item", name = "bf-big-building", amount = 1},
            {type = "item", name = item.name, amount = 40},
        },
        result = name,
    }
end

local increaseEnergyUsage = function(energy)
    local amount = tonumber(string.sub(energy, 0,-3))
    local unit = string.sub(energy, -2)
    return tostring(amount * speedFactor) .. unit
end

local updatePipeConnections = function(position, offset, oldCollision)
    if (math.abs(position[1]) > math.abs(position[2])) then
        if (position[1] < 0) then position[1] = position[1] - offset else position[1] = position[1] + offset end
        position[2] = position[2] + ((position[2] / oldCollision) * offset)
    else
        position[1] = position[1] + ((position[1] / oldCollision) * offset)
        if (position[2] < 0) then position[2] = position[2] - offset else position[2] = position[2] + offset end
    end
    if position[1] < 0 then position[1] = math.ceil(position[1]) else position[1] = math.floor(position[1]) end
    if position[2] < 0 then position[2] = math.ceil(position[2]) else position[2] = math.floor(position[2]) end
    if (sizeFactor % 2 == 0) then
        if (math.abs(position[1]) < math.abs(position[2])) then
            if position[1] > 0 then position[1] = position[1] + 0.5 else position[1] = position[1] - 0.5 end
        else
            if position[2] > 0 then position[2] = position[2] + 0.5 else position[2] = position[2] - 0.5 end
        end
    end
end

local scaleSize = function(entity)
    local oldSize = baseValue(entity.selection_box)
    local oldCollision = baseValue(entity.collision_box)
    if (oldSize < oldCollision) then error("for " .. entity.name .. " size base value " .. oldSize " is smaller than collision base value " .. oldCollision) end

    local collisionOffset = oldSize - oldCollision
    local newSize = oldSize * sizeFactor
    local newCollision = newSize - collisionOffset
    entity.collision_box = {{ -newCollision, -newCollision }, {newCollision, newCollision}}
    entity.selection_box = {{ -newSize, -newSize}, {newSize, newSize}}

    if entity.fluid_boxes then
        local offset = newCollision - oldCollision
        for _, box in pairs(entity.fluid_boxes) do
            if (type(box) == "table") then
                if (box.base_area) then
                    box.base_area = box.base_area * 10
                end
                for _, c in pairs(box.pipe_connections) do
                    updatePipeConnections(c.position, offset, oldCollision)
                end
            end
        end
    end
    adjustVisuals(entity, sizeFactor, 1 / speedFactor)
end

local bigEntity = function(entity)
    local bigEntity = util.table.deepcopy(entity)
    bigEntity.name = "bf-" .. entity.name
    bigEntity.localised_name = bigName(entity)
    if bigEntity.crafting_speed then bigEntity.crafting_speed = entity.crafting_speed * speedFactor end
    if bigEntity.researching_speed then bigEntity.researching_speed = entity.researching_speed * speedFactor end
    bigEntity.max_health = entity.max_health * sizeFactor
    bigEntity.energy_usage = increaseEnergyUsage(entity.energy_usage)
    bigEntity.fast_replaceable_group = nil
    bigEntity.next_upgrade = nil
    if moduleSlots >= 0 then bigEntity.module_specification.module_slots = moduleSlots end
    bigEntity.flags = flags
    bigEntity.create_ghost_on_death = minable or craftable
    bigEntity.scale_entity_info_icon = scaleIcon
    bigEntity.order = "zzz"
    scaleSize(bigEntity)

    if minable then
        bigEntity.minable = { mining_time = 2, result = bigEntity.name }
    else
        bigEntity.minable = nil
    end

    return bigEntity
end

local generateMachine = function(item, entity)
    if craftable or minable then
        data:extend({
            bigItem(item)
        })
    end
    if craftable then
        data:extend({
            bigTechnology(item),
            bigRecipe(item),
        })
    end
    local big_entity = bigEntity(entity)
    data:extend({ big_entity })
    return big_entity.name
end

return function(factories)
    local big_factories = {}
    for _, def in pairs(factories) do
        local entity = data.raw[def[1]][def[2]]
        local item = data.raw.item[def[2]]
        if (type(entity) ~= "table") or (type(item) ~= "table") then
            print("Missing item: " .. def[1] .. "." .. def[2])
        else
            table.insert(big_factories, generateMachine(item, entity))
        end
    end
    return big_factories
end
