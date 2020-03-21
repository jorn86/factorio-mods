local tiers = settings.startup["radar-tech-tiers"].value
local base = data.raw["radar"]["radar"]

local function update(tier, radar)
    radar.energy_usage = (tier + 3) * 100 .. "kW"
    radar.energy_per_sector = (tier + 10) * 1000 .. "kJ"
    radar.max_distance_of_sector_revealed = (tier + 7) * 2
    radar.max_distance_of_nearby_sector_revealed = tier + 3
    radar.rotation_speed = (tier + 10) * 0.001
    radar.placeable_by = { item = "radar", count = 1 }
end

for tier = 1,tiers do
    local radar = table.deepcopy(base)
    radar.name = "rt-radar-" .. tier
    radar.localised_name = { "entity-name.radar" }
    radar.order = "rt-radar-" .. tier
    update(tier, radar)
    data:extend({ radar })
end

data:extend({
    {
        type = "technology",
        name = "rt-upgrade-tech-1",
        unit = {
            count = 100,
            time = 15,
            ingredients = {
                { "automation-science-pack", 1 },
            },
        },
        prerequisites = { "military" },
        effects = {{ type = "nothing", effect_description = { "rt-radar.technology-description" } }},
        icons = { { icon = "__base__/graphics/entity/radar/radar.png", icon_size = 100, shift = { 0, -15 }, scale = 0.9 }, }
    },
    {
        type = "technology",
        name = "rt-upgrade-tech-2",
        unit = {
            count = 200,
            time = 30,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
            },
        },
        prerequisites = { "military-2", "rt-upgrade-tech-1" },
        effects = {{ type = "nothing", effect_description = { "rt-radar.technology-description" } }},
        icons = { { icon = "__base__/graphics/entity/radar/radar.png", icon_size = 100, shift = { 0, -15 }, scale = 0.9 }, }
    },
    {
        type = "technology",
        name = "rt-upgrade-tech-3",
        unit = {
            count = 300,
            time = 30,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
            },
        },
        prerequisites = { "speed-module", "rt-upgrade-tech-2" },
        effects = {{ type = "nothing", effect_description = { "rt-radar.technology-description" } }},
        icons = { { icon = "__base__/graphics/entity/radar/radar.png", icon_size = 100, shift = { 0, -15 }, scale = 0.9 }, }
    },
    {
        type = "technology",
        name = "rt-upgrade-tech-4",
        unit = {
            count = 400,
            time = 30,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
            },
        },
        prerequisites = { "advanced-electronics-2", "rt-upgrade-tech-3" },
        effects = {{ type = "nothing", effect_description = { "rt-radar.technology-description" } }},
        icons = { { icon = "__base__/graphics/entity/radar/radar.png", icon_size = 100, shift = { 0, -15 }, scale = 0.9 }, }
    },
    {
        type = "technology",
        name = "rt-upgrade-tech-5",
        unit = {
            count = 500,
            time = 60,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
            },
        },
        prerequisites = { "speed-module-3", "rt-upgrade-tech-4" },
        effects = {{ type = "nothing", effect_description = { "rt-radar.technology-description" } }},
        icons = { { icon = "__base__/graphics/entity/radar/radar.png", icon_size = 100, shift = { 0, -15 }, scale = 0.9 }, }
    },
    {
        type = "technology",
        name = "rt-upgrade-tech-6",
        unit = {
            count = 600,
            time = 60,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 },
            },
        },
        prerequisites = { "rocket-silo", "rt-upgrade-tech-5" },
        effects = {{ type = "nothing", effect_description = { "rt-radar.technology-description" } }},
        icons = { { icon = "__base__/graphics/entity/radar/radar.png", icon_size = 100, shift = { 0, -15 }, scale = 0.9 }, }
    },
    {
        type = "technology",
        name = "rt-upgrade-tech-7",
        upgrade = true,
        max_level = tiers,
        unit = {
            count_formula = "L * 100",
            time = 60,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 },
            },
        },
        prerequisites = { "space-science-pack", "rt-upgrade-tech-6" },
        effects = {{ type = "nothing", effect_description = { "rt-radar.technology-description" } }},
        icons = { { icon = "__base__/graphics/entity/radar/radar.png", icon_size = 100, shift = { 0, -15 }, scale = 0.9 }, }
    }
})
