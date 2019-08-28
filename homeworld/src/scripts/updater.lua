require("scripts.utility")

function register_updater(name, update)
    local function init_global()
        if not global[name] then
            global[name] = {}
            for_all_entities(name, function(entity)
                table.insert(global[name], entity)
            end)
            print("init " .. name .. " with " .. table_size(global[name]))
        end
    end

    local function on_built(entity)
        init_global()
        if entity.name == name then
            update(entity)
            table.insert(global[name],  entity)
        end
    end

    local function on_destroy(entity)
        init_global()
        if entity.name ~= name then return end
        for i, e in pairs(global[name]) do
            if e == entity then
                table.remove(global[name], i)
                return
            end
        end
        print("on_destroy didn't find anything")
    end

    local function update_all()
        init_global()
        for _, entity in pairs(global[name]) do
            if entity.valid then update(entity) end
        end
    end

    return {
        on_init = function() global[name] = {} end,
        on_built = on_built,
        on_destroy = on_destroy,
        update_all = update_all,
        update_single = function() end,
    }
end

local function create_beacon(surface, position)
    local beacon = surface.create_entity{name="hw-beacon", position=position, force="player"}
    if beacon and beacon.valid then
        beacon.destructible = false
        return beacon
    end
    print("failed to create beacon at " .. serpent.line(position))
end

local function find_beacon(entity)
    local beacon = entity.surface.find_entities_filtered{name = "hw-beacon", area = areaWithOffset(entity.position, 1)}[1]
    if beacon and beacon.valid then
        return beacon
    end
    print("failed to find beacon at " .. serpent.line(entity.position))
end

function register_updater_with_beacon(name, update)
    local function init_global()
        if not global[name] then
            global[name] = {}
            for_all_entities(name, function(entity)
                table.insert(global[name], { entity, find_beacon(entity) } )
            end)
            print("init " .. name .. " with " .. table_size(global[name]))
        end
    end

    local function on_built(entity)
        init_global()
        if entity.name == name then
            local beacon = create_beacon(entity.surface, entity.position)
            update(entity, beacon)
            table.insert(global[name], { entity, beacon })
        end
    end

    local function on_destroy(entity)
        if entity.name ~= name then return end
        init_global()
        for i, e in pairs(global[name]) do
            if e[1] == entity then
                if e[2].valid then e[2].destroy() end
                table.remove(global[name], i)
                return
            end
        end
        print("on_destroy didn't find anything")
    end

    local function update_single(event)
        init_global()
        local size = table_size(global[name])
        if size == 0 then return end
        local index = (event.tick % size) + 1 -- f'ing 1-based indices
        local entity = global[name][index][1]
        local beacon = global[name][index][2]
        if entity.valid and beacon.valid then
            update(entity, beacon)
        end
    end

    return {
        on_init = function() global[name] = {} end,
        on_built = on_built,
        on_destroy = on_destroy,
        update_all = function() end,
        update_single = update_single,
    }
end
