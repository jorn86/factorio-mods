require("scripts.utility")

local function removeLoaders(entity)
    if not entity.valid or string.sub(entity.name, 0,3) ~= "bf-" then return end
    if entity.name == "bf-loader" then return end

    local box = entity.prototype.collision_box
    local area = areaWithOffset(box, entity.position, 0.7)

    local nearby = entity.surface.find_entities_filtered{area = area, name = "bf-loader"}
    for _, loader in pairs (nearby) do
        loader.destroy()
    end
end

local function createLoader(surface, suppress, position, type, direction, force)
    for _,p in pairs(suppress) do
        if math.floor(p.x) == math.floor(position.x) and math.floor(p.y) == math.floor(position.y) then return end
    end
    return surface.create_entity{name = "bf-loader", position = position, type = type, direction = direction, force = force}
end

local function generateLoaders(entity)
    if not entity.valid or string.sub(entity.name, 0,3) ~= "bf-" then return end

    local suppress = {}
    if settings.global["bf-suppress-loaders"].value then
        if entity.prototype.fluidbox_prototypes then
            for _,e in pairs(entity.prototype.fluidbox_prototypes) do
                for _, c in pairs(e.pipe_connections) do
                    for _, p in pairs(c.positions) do
                        table.insert(suppress, { x = p.x + entity.position.x, y = p.y + entity.position.y })
                    end
                end
            end
        end
    end
    local box = entity.prototype.collision_box
    local entityArea = areaWithOffset(box, entity.position, 0)
    local distance = 0.5
    for x = entityArea.left_top.x + 1, entityArea.right_bottom.x - 1 do
        createLoader(entity.surface, suppress, {x = x, y = entityArea.left_top.y - distance}, "input", defines.direction.south, entity.force)
        createLoader(entity.surface, suppress, {x = x, y = entityArea.right_bottom.y + distance}, "input", defines.direction.north, entity.force)
    end
    for y = entityArea.left_top.y + 1, entityArea.right_bottom.y - 1 do
        createLoader(entity.surface, suppress,  {x = entityArea.left_top.x - distance, y = y}, "input", defines.direction.east, entity.force)
        createLoader(entity.surface, suppress, {x = entityArea.right_bottom.x + distance, y = y}, "input", defines.direction.west, entity.force)
    end
end

function entity_mined(event)
    local entity = event.entity
    if not (entity and entity.valid) then return end
    removeLoaders(entity)
end

function entity_built(event)
    local entity = event.created_entity or event.entity
    if not (entity and entity.valid) then return end
    if not (settings.global["bf-loaders"].value) then return end
    generateLoaders(entity)
end

function regenerate(event)
    for _,entity in pairs(event.entities) do
        removeLoaders(entity)
        generateLoaders(entity)
    end
end

function remove(event)
    for _,loader in pairs(event.entities) do
        loader.destroy()
    end
end
