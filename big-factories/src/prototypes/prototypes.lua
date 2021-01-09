require("util")
require("scripts.utility")
local adjust_visuals = require("scripts.adjustVisuals")
local factories = require("scripts.findFactories")(function(type) return data.raw[type] end)

local size_factor = settings.startup["bf-size-factor"].value
local speed_factor = settings.startup["bf-speed-factor"].value
local minable = settings.startup["bf-minable"].value
local craftable = settings.startup["bf-craftable"].value
local module_slots = settings.startup["bf-module-slots"].value
local scale_icon = settings.startup["bf-scale-icon"].value

local flags = {"placeable-neutral", "placeable-player", "player-creation"}
if not minable then table.insert(flags, "not-deconstructable") end
if not (minable or craftable) then table.insert(flags, "not-blueprintable") end

local big_localised_name = function(itemOrEntity)
    if (itemOrEntity.localised_name) then
        return {"", "Big ", itemOrEntity.localised_name}
    else
        return {"", "Big ", {"entity-name." .. itemOrEntity.name}}
    end
end

local big_item = function(def)
    local item = data.raw["item"][def.name]
    local big_item = util.table.deepcopy(item)
    big_item.name = def.big_name
    big_item.localised_name = big_localised_name(item)
    big_item.place_result = big_item.name
    big_item.subgroup = "big-factory"
    big_item.order = "bf[" .. def.big_name .. "]"
    return big_item
end

local big_technology = function(def)
    local item = data.raw["item"][def.name]
    local original_tech = findTechThatUnlocks(item.name)
    if not original_tech then return end
    local big_tech = {
        type = "technology",
        name = def.big_name,
        localised_name = big_localised_name(item),
        icons = original_tech.icons,
        icon_size = original_tech.icon_size,
        prerequisites = { "bf-construction" },
        effects = {{ type = "unlock-recipe", recipe = def.big_name }},
        unit = {
            ingredients = {{"automation-science-pack", 1},{"logistic-science-pack", 1},{"chemical-science-pack", 1},{"production-science-pack", 1}},
            count = 500,
            time = 60
        }
    }
    if (original_tech.enabled ~= false) then
        table.insert(big_tech.prerequisites, original_tech.name)
    end
    return big_tech
end

local big_recipe = function(def)
    local item = data.raw["item"][def.name]
    return {
        type = "recipe",
        name = def.big_name,
        localised_name = big_localised_name(item),
        order = "zbf[" .. def.big_name .. "]",
        energy_required = 1,
        enabled = false,
        ingredients = {
            {type = "item", name = "bf-big-building", amount = 1},
            {type = "item", name = item.name, amount = speed_factor},
        },
        result = def.big_name,
    }
end

local increase_energy_usage = function(energy)
    local amount = tonumber(string.sub(energy, 0,-3))
    local unit = string.sub(energy, -2)
    return tostring(amount * speed_factor) .. unit
end

local round = function(num, add_before, correct_after, add_after)
    if num < 0 then return math.ceil(num - add_before) - correct_after - add_after else return math.floor(num + add_before) + correct_after + add_after end
end

local scale_size = function(entity)
    local old_size = baseValue(entity.selection_box)
    local old_collision = baseValue(entity.collision_box)
    if (old_size < old_collision) then error("for " .. entity.name .. " size base value " .. old_size " is smaller than collision base value " .. old_collision) end

    local collision_offset = old_size - old_collision
    local new_size = old_size * size_factor
    local new_collision = new_size - collision_offset

    entity.collision_box = {{ -new_collision, -new_collision }, { new_collision, new_collision }}
    entity.selection_box = {{ -new_size, -new_size }, { new_size, new_size }}

    if entity.fluid_boxes then
        local offset = new_collision - old_collision
        for _, box in pairs(entity.fluid_boxes) do
            if (type(box) == "table") then
                if (box.base_area) then
                    box.base_area = box.base_area * speed_factor
                end
                for _, c in pairs(box.pipe_connections) do
                    local inside, outside
                    if math.abs(c.position[1]) < math.abs(c.position[2])
                        then inside = 1  outside = 2
                        else inside = 2  outside = 1
                    end

                    local add_after
                    if (size_factor % 2 == 0 and c.position[outside] % 1 == 0) then add_after = 0.5 else add_after = 0 end

                    c.position[inside] = round(c.position[inside] + ((c.position[inside] / old_collision) * offset), 0, c.position[inside] % 1, add_after)
                    c.position[outside] = round(c.position[outside], offset, c.position[outside] % 1, add_after)
                end
            end
        end
    end
    adjust_visuals(entity, size_factor, 1 / speed_factor)
end

local big_entity = function(def)
    local entity = data.raw[def.type][def.name]
    local big_entity = util.table.deepcopy(entity)
    big_entity.name = def.big_name
    big_entity.localised_name = big_localised_name(entity)
    if entity.crafting_speed then big_entity.crafting_speed = entity.crafting_speed * speed_factor end
    if entity.researching_speed then big_entity.researching_speed = entity.researching_speed * speed_factor end
    big_entity.max_health = entity.max_health * size_factor
    big_entity.energy_usage = increase_energy_usage(entity.energy_usage)
    big_entity.fast_replaceable_group = nil
    big_entity.next_upgrade = nil
    if module_slots >= 0 then big_entity.module_specification.module_slots = module_slots end
    big_entity.flags = flags
    big_entity.create_ghost_on_death = minable or craftable
    big_entity.scale_entity_info_icon = scale_icon
    big_entity.order = "bf[" .. def.big_name .. "]"
    scale_size(big_entity)

    if minable then
        big_entity.minable = { mining_time = 2, result = def.big_name }
    else
        big_entity.minable = nil
    end

    table.insert(data.raw["selection-tool"]["bf-loader-tool"].entity_filters, def.big_name)
    return big_entity
end

local generate_machine = function(def)
    data:extend({ big_item(def), big_entity(def), })
    if craftable then
        data:extend({ big_technology(def), big_recipe(def), })
    end
end

for _, def in pairs(factories) do
    generate_machine(def)
end
