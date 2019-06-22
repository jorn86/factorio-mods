require('scripts.utility')

local richness = {
    ["deepwater"] = 0.25,
    ["deepwater-green"] = 0.25,
    ["water"] = 0.15,
    ["water-green"] = 0.15,
}

local function calculate_richness(entity, area)
    -- Calculate water tiles
    local surface = entity.surface
    local total_richness = -30
    for x = -area, area do
        for y = -area, area do
            local tile = surface.get_tile(x + entity.position.x, y + entity.position.y)
            total_richness = total_richness + (richness[tile.name] or 0)
        end
    end
    local fisheries = table_size(surface.find_entities_filtered{ area = areaWithOffset(entity.position, area * 2), name = "hw-fishery"}) - 1
    total_richness = total_richness - (50 * fisheries)
    return math.floor(total_richness)
end

local function update_richness(fishery)
    fill_beacon(find_beacon(fishery), calculate_richness(fishery, 12))
end

return {
    on_built = function(entity)
        if entity.name == "hw-fishery" then
            entity.set_recipe('hw-fish')
            entity.recipe_locked = true
            create_beacon(entity.surface, entity.position)
            update_richness(entity)
        end
    end,

    on_destroy = function(entity)
        if entity.name == "hw-fishery" then
            local beacon = find_beacon(entity)
            if beacon and beacon.valid then beacon.destroy() end
        end
    end,

    update = function()
        for_all_entities("hw-fishery", update_richness)
    end,
}
