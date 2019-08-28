require("prototypes.achievements")
require("prototypes.brewery")
require("prototypes.farm")
require("prototypes.fishery")
require("prototypes.portal")
require("prototypes.sawmill")
require("prototypes.technology")

data:extend({
    {
        type = "item-subgroup",
        name = "hw-intermediate",
        group = "intermediate-products",
        order = "h[homeworld]",
    },
    {
        type = "beacon",
        name = "hw-beacon",
        minable = nil,
        max_health = 200,
        collision_box = {{0, 0}, {0, 0}},
        allowed_effects = {"speed"},
        supply_area_distance = 1,
        energy_source = { type = "void" },
        energy_usage = "1W",
        distribution_effectivity = 1,
        module_specification = { module_slots = 200 },
        base_picture = { filename = "__homeworld-reloaded__/graphics/empty.png", size = 1 },
        animation = { filename = "__homeworld-reloaded__/graphics/empty.png", frame_count = 1, size = 1, priority = "low", },
        animation_shadow = {filename = "__homeworld-reloaded__/graphics/empty.png", frame_count = 1, size = 1, priority = "low", },
    },
    {
        type = "module",
        name = "hw-fertile-module",
        icon = "__homeworld-reloaded__/graphics/empty.png",
        icon_size = 16,
        subgroup = "module",
        category = "speed",
        order = "z[hw]-a[fertile]",
        stack_size = 50,
        tier = 1,
        effect = { speed = {bonus = 0.01}}
    },
    {
        type = "module",
        name = "hw-polluted-module",
        icon = "__homeworld-reloaded__/graphics/empty.png",
        icon_size = 16,
        subgroup = "module",
        category = "speed",
        order = "z[hw]-b[polluted]",
        stack_size = 50,
        tier = 1,
        effect = { speed = {bonus = -0.01}}
    },
})
