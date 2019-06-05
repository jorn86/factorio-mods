local findFactories = require('scripts.findFactories')
require('scripts.utility')
local spawn = settings.global['bf-spawn'].value
local spawnChance = settings.global['bf-spawn-chance'].value

local function chooseNextSpawnType()
    local totalChance = 0
    for _,v in pairs(global.factories) do
        totalChance = totalChance + v.chance
    end

    local selected = math.random() * totalChance
    local currentChance = 0
    for name, v in pairs(global.factories) do
        currentChance = currentChance + v.chance
        if (currentChance >= selected) then return name end
    end
    error('no hit: ' .. tostring(selected) .. '/' .. tostring(totalChance) .. '/' .. tostring(currentChance))
end

local function doSpawn(center, surface, entityname)
    local force = game.forces.player
    if surface.can_place_entity{name=entityname, position=center, force=force, build_check_type=defines.build_check_type.ghost_place, forced=true} and clearArea(center, surface) then
        local entity = surface.create_entity{name=entityname, position=center, force=force, raise_built=true}
        script.raise_event(defines.events.script_raised_built, {entity=entity, created_entity=entity})
        return true
    end
    return false
end

function triggerSpawn(event)
    if not spawn or math.random() > spawnChance then
        return
    end

    -- Chunk center
    local center = {
        x = (event.area.left_top.x + event.area.right_bottom.x) / 2,
        y = (event.area.left_top.y + event.area.right_bottom.y) / 2,
    }

    local nextSpawnType = chooseNextSpawnType()
    local proto = game.entity_prototypes[nextSpawnType]
    local box = proto.collision_box
    local maxOffset = 15 - baseValue(box)
    if (maxOffset > 0) then
        center = { x = center.x + math.random(-maxOffset, maxOffset), y = center.y + math.random(-maxOffset, maxOffset) }
    end

    if doSpawn(center, event.surface, nextSpawnType) then
        global.factories[nextSpawnType].count = global.factories[nextSpawnType].count + 1
    end
end

function spawnInit()
    global.factories = {}
    for _, f in pairs(findFactories(game.active_mods)) do
        global.factories['bf-' .. f[2]] = {count = 0, chance = f[3]}
    end
end
