data:extend({
    {
        type = "item",
        name = "warehouse",
        icon = "__base__/graphics/icons/steel-chest.png",
        flags = {"goes-to-quickbar"},
        subgroup = "storage",
        order = "b[storage]-c[warehouse]",
        place_result = "warehouse",
        stack_size = 50
    },
    {
        type = "recipe",
        name = "warehouse",
        enabled = false,
        energy_required = 5,
        ingredients = {
            {"steel-plate", 20},
        },
        result = "warehouse"
    },
    {
        type = "technology",
        name = "warehouse",
        icon = "__base__/graphics/icons/steel-chest.png",
        effects = {
            {
                type = "unlock-recipe",
                recipe = "warehouse"
            }
        },
        prerequisites = {"steel-processing"},
        unit = {
            count = 50,
            ingredients = {{"science-pack-1", 2}},
            time = 15
        },
    },
    {
        type = "container",
        name = "warehouse",
        icon = "__base__/graphics/icons/steel-chest.png",
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = 2, result = "warehouse"},
        max_health = 300,
        corpse = "small-remnants",
        open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.65 },
        close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7 },
        resistances =
        {
            {
                type = "fire",
                percent = 90
            }
        },
        collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        fast_replaceable_group = "container",
        inventory_size = 500,
        vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
        picture =
        {
            filename = "__base__/graphics/entity/steel-chest/steel-chest.png",
            priority = "extra-high",
            width = 48,
            height = 34,
            scale = 3,
            shift = {0.6, 0}
        }
    },
})
