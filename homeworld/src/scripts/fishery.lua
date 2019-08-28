require("scripts.utility")

local richness = {
    ["deepwater"] = 0.25,
    ["deepwater-green"] = 0.25,
    ["water"] = 0.15,
    ["water-green"] = 0.15,
}

local function calculate_richness(fishery, area)
    local surface = fishery.surface
    local total_richness = -30
    for x = -area, area do
        for y = -area, area do
            local tile = surface.get_tile(x + fishery.position.x, y + fishery.position.y)
            total_richness = total_richness + (richness[tile.name] or 0)
        end
    end
    local fisheries = table_size(surface.find_entities_filtered{ area = areaWithOffset(fishery.position, area * 2), name = "hw-fishery"}) - 1
    total_richness = total_richness - (50 * fisheries)
    return math.floor(total_richness)
end

return {
    update = function (fishery, beacon)
        if not fishery.get_recipe() then
            fishery.set_recipe("hw-fish")
            fishery.recipe_locked = true
        end
        fill_beacon(beacon, calculate_richness(fishery, 12))
    end
}
