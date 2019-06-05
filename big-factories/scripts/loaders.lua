require('scripts.utility')

local function removeLoaders(entity)
    if string.sub(entity.name, 0,3) ~= 'bf-' then return end
    if entity.name == 'bf-loader' then return end

    local box = entity.prototype.collision_box
    local area = areaWithOffset(box, entity.position, 0.7)

    local nearby = entity.surface.find_entities_filtered{area = area, name = "bf-loader"}
    for _, loader in pairs (nearby) do
        loader.destroy()
    end
end

local function createLoader(surface, position, type, direction, force)
    surface.create_entity{name = 'bf-loader', position = position, type = type, direction = direction, force = force}
end

local function generateLoaders(entity)
    if string.sub(entity.name, 0,3) ~= 'bf-' then return end

    local box = entity.prototype.collision_box
    local entityArea = areaWithOffset(box, entity.position, 0)
    local distance = 0.5
    for x = entityArea.left_top.x + 1, entityArea.right_bottom.x - 1 do
        createLoader(entity.surface, {x = x, y = entityArea.left_top.y - distance}, "input", defines.direction.south, entity.force)
        createLoader(entity.surface, {x = x, y = entityArea.right_bottom.y + distance}, "input", defines.direction.north, entity.force)
    end
    for y = entityArea.left_top.y + 1, entityArea.right_bottom.y - 1 do
        createLoader(entity.surface, {x = entityArea.left_top.x - distance, y = y}, "input", defines.direction.east, entity.force)
        createLoader(entity.surface, {x = entityArea.right_bottom.x + distance, y = y}, "input", defines.direction.west, entity.force)
    end
end

function entityMined(event)
    local entity = event.entity
    if not (entity and entity.valid) then return end
    removeLoaders(entity)
end

function entityBuilt(event)
    local entity = event.created_entity
    if not (entity and entity.valid) then return end
    generateLoaders(entity)
end
