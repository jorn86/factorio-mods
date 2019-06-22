data:extend({
    {
        type = "recipe-category",
        name = "hw-fishery"
    },
    {
        type = "assembling-machine",
        name = "hw-fishery",
        icon = "__base__/graphics/icons/fish.png",
        icon_size = 32,
        flags = { "player-creation", "placeable-player" },
        minable = { mining_time = 0.3, result = "hw-fishery" },
        max_health = 50,
        corpse = "big-remnants",
        collision_mask = { "ground-tile" },
        collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
        selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
        energy_usage = "1W",
        energy_source = { type = "void" },
        crafting_speed = 1,
        crafting_categories = { "hw-fishery" },
        allowed_effects = {"speed"},
        animation = {
            frame_count = 1,
            filename = "__homeworld-reloaded__/graphics/entity/fishery.png",
            priority = "low",
            width = 192,
            height = 230,
            scale = 0.8,
            shift = {0, -0.8}
        },
    },
    {
        type = "item",
        name = "hw-fishery",
        icon = "__homeworld-reloaded__/graphics/icons/fishery.png",
        icon_size = 32,
        subgroup = "extraction-machine",
        place_result = "hw-fishery",
        order = "e[hw]-b[fishery]",
        stack_size = 20,
    },
    {
        type = "recipe",
        name = "hw-fishery",
        enabled = false,
        ingredients = {
            { "wood", 10 },
            { "iron-plate", 10 }
        },
        result = "hw-fishery"
    },
    {
        type = "recipe",
        name = "hw-fish",
        enabled = false,
        hidden = true,
        ingredients = {
            { "wood", 10 },
            { "iron-plate", 10 }
        },
        category = "hw-fishery",
        energy_required = 60,
        ingredients = {},
        result = "raw-fish",
        result_count = 100,
    },
})
