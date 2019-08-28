data:extend({
    {
        type = "recipe-category",
        name = "hw-brewery"
    },
    {
        type = "assembling-machine",
        name = "hw-brewery",
        icon = "__homeworld-reloaded__/graphics/icons/brewery.png",
        icon_size = 32,
        flags = { "player-creation", "placeable-player" },
        minable = { mining_time = 0.3, result = "hw-brewery" },
        max_health = 50,
        corpse = "big-remnants",
        dying_explosion = "medium-explosion",
        collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        module_slots = 2,
        energy_usage = "20kW",
        crafting_speed = 1,
        crafting_categories = { "hw-brewery" },
        module_specification = { module_slots = 3, },
        allowed_effects = {"consumption", "speed", "productivity", "pollution"},
        fluid_boxes =
        {
            {
                production_type = "input",
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = -1,
                pipe_connections = {{ type="input", position = {-1, -2} }}
            },
            {
                production_type = "input",
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = -1,
                pipe_connections = {{ type="input", position = {1, -2} }}
            },
            {
                production_type = "output",
                pipe_covers = pipecoverspictures(),
                base_level = 1,
                pipe_connections = {{ position = {-1, 2} }}
            },
            {
                production_type = "output",
                pipe_covers = pipecoverspictures(),
                base_level = 1,
                pipe_connections = {{ position = {1, 2} }}
            }
        },
        animation =
        {
            north =
            {
                filename = "__homeworld-reloaded__/graphics/entity/distillery/distillery.png",
                width = 156,
                height = 141,
                frame_count = 1,
                shift = {0.5, -0.078125}
            },
            west =
            {
                filename = "__homeworld-reloaded__/graphics/entity/distillery/distillery.png",
                x = 156,
                width = 156,
                height = 141,
                frame_count = 1,
                shift = {0.5, -0.078125}
            },
            south =
            {
                filename = "__homeworld-reloaded__/graphics/entity/distillery/distillery.png",
                x = 312,
                width = 156,
                height = 141,
                frame_count = 1,
                shift = {0.5, -0.078125}
            },
            east =
            {
                filename = "__homeworld-reloaded__/graphics/entity/distillery/distillery.png",
                x = 468,
                width = 156,
                height = 141,
                frame_count = 1,
                shift = {0.5, -0.078125}
            }
        },
        working_visualisations =
        {
            {
                north_position = {0.94, -0.73},
                west_position = {-0.3, 0.02},
                south_position = {-0.97, -1.47},
                east_position = {0.05, -1.46},
                animation =
                {
                    filename = "__homeworld-reloaded__/graphics/entity/distillery/boiling-green-patch.png",
                    frame_count = 35,
                    width = 17,
                    height = 12,
                    animation_speed = 0.15
                }
            },
            {
                north_position = {1.4, -0.23},
                west_position = {-0.3, 0.55},
                south_position = {-1, -1},
                east_position = {0.05, -0.96},
                north_animation =
                {
                    filename = "__homeworld-reloaded__/graphics/entity/distillery/boiling-window-green-patch.png",
                    frame_count = 1,
                    width = 21,
                    height = 10
                },
                west_animation =
                {
                    filename = "__homeworld-reloaded__/graphics/entity/distillery/boiling-window-green-patch.png",
                    x = 21,
                    frame_count = 1,
                    width = 21,
                    height = 10
                },
                south_animation =
                {
                    filename = "__homeworld-reloaded__/graphics/entity/distillery/boiling-window-green-patch.png",
                    x = 42,
                    frame_count = 1,
                    width = 21,
                    height = 10
                }
            }
        },
        working_sound =
        {
            sound = {
                {
                    filename = "__base__/sound/chemical-plant.ogg",
                    volume = 0.8
                }
            },
            idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
            apparent_volume = 1.5,
        },
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            emissions = 0.03 / 3.5
        },
    },
    {
        type = "item",
        name = "hw-brewery",
        icon = "__homeworld-reloaded__/graphics/icons/brewery.png",
        icon_size = 32,
        subgroup = "production-machine",
        place_result = "hw-brewery",
        order = "c[hw]-z[brewery]",
        stack_size = 20,
    },
    {
        type = "recipe",
        name = "hw-brewery",
        enabled = false,
        ingredients = {
            { "steel-plate", 5 },
            { "iron-gear-wheel", 5 },
            { "electronic-circuit", 2 },
            { "pipe", 5 }
        },
        result = "hw-brewery"
    },
    {
        type = "item",
        name = "hw-barrel",
        icon = "__homeworld-reloaded__/graphics/icons/wood-barrel.png",
        icon_size = 32,
        subgroup = "hw-intermediate",
        order = "hw-c[barrel]",
        stack_size = 200,
    },
    {
        type = "recipe",
        name = "hw-barrel",
        enabled = false,
        ingredients = {
            { "iron-plate", 1 },
            { "wood", 2 },
        },
        result = "hw-barrel"
    },
    {
        type = "item",
        name = "hw-beer-barrel",
        icon = "__homeworld-reloaded__/graphics/icons/beer.png",
        icon_size = 32,
        subgroup = "hw-intermediate",
        order = "hw-d[beer]",
        stack_size = 200,
    },
    {
        type = "recipe",
        name = "hw-beer-barrel",
        enabled = false,
        always_show_made_in = true,
        ingredients = {
            { type = "fluid", name = "water", amount = 500 },
            { "hw-wheat", 10 },
            { "hw-hops", 10 },
            { "hw-barrel", 1 },
        },
        energy_required = 10,
        category = "hw-brewery",
        result = "hw-beer-barrel"
    },
    {
        type = "item",
        name = "hw-wine-barrel",
        icon = "__homeworld-reloaded__/graphics/icons/wine.png",
        icon_size = 32,
        subgroup = "hw-intermediate",
        order = "hw-g[wine]",
        stack_size = 200,
    },
    {
        type = "recipe",
        name = "hw-wine-barrel",
        enabled = false,
        always_show_made_in = true,
        ingredients = {
            { type = "fluid", name = "water", amount = 500 },
            { "hw-grapes", 20 },
            { "hw-barrel", 1 },
        },
        energy_required = 20,
        category = "hw-brewery",
        result = "hw-wine-barrel"
    },
})
