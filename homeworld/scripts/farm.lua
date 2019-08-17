require("scripts.utility")

local richness = {
    ["concrete"] = -1.00,
    ["dirt-1"] = 0.50,
    ["dirt-2"] = 0.50,
    ["dirt-3"] = 0.50,
    ["dirt-4"] = 0.50,
    ["dirt-5"] = 0.50,
    ["dirt-6"] = 0.50,
    ["dirt-7"] = 0.50,
    ["dry-dirt"] = 0.40,
    ["grass-1"] = 0.85,
    ["grass-2"] = 0.75,
    ["grass-3"] = 0.65,
    ["grass-4"] = 0.55,
    ["hazard-concrete-left"] = -1.00,
    ["hazard-concrete-right"] = -1.00,
    ["lab-dark-1"] = -1.00,
    ["lab-dark-2"] = -1.00,
    ["out-of-map"] = 0.00, --0 for now, might make negative.
    ["red-desert-0"] = -1.00,
    ["red-desert-1"] = -1.00,
    ["red-desert-2"] = -1.00,
    ["red-desert-3"] = -1.00,
    ["sand-1"] = -1.00,
    ["sand-2"] = -1.00,
    ["sand-3"] = -1.00,
    ["stone-path"] = -1.00,
}

local function calculate_richness(entity, area)
    -- Calculate soil richness.
    local surface = entity.surface
    local total_richness = 0
    for x = -area, area do
        for y = -area, area do
            local tile = surface.get_tile(x + entity.position.x, y + entity.position.y)
            total_richness = total_richness + (richness[tile.name] or 0)
        end
    end
    return math.floor(total_richness)
end

return {
    update = function (farm, beacon)
        fill_beacon(beacon, calculate_richness(farm, 4))
    end
}
