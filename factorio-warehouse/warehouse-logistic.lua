data:extend({
    {
        type = "item",
        name = "warehouse-logistics",
        icon = "__base__/graphics/icons/logistic-chest-storage.png",
        flags = {"goes-to-quickbar"},
        subgroup = "logistic-network",
        order = "b[storage]-c[logistic-chest-warehouse]",
        place_result = "warehouse-logistics",
        stack_size = 50
    },
    {
        type = "recipe",
        name = "warehouse-logistics",
        enabled = false,
        energy_required = 5,
        ingredients = {
            {"warehouse", 1},
            {"electronic-circuit", 5},
            {"advanced-circuit", 5}
        },
        result = "warehouse-logistics"
    },
    {
        type = "technology",
        name = "warehouse-logistics",
        icon = "__base__/graphics/icons/logistic-chest-storage.png",
        effects = {
            {
                type = "unlock-recipe",
                recipe = "warehouse-logistics"
            }
        },
        prerequisites = {"warehouse", "construction-robotics"},
        unit = {
            count = 50,
            ingredients = {{"science-pack-1", 1}, {"science-pack-2", 1}},
            time = 45
        },
    },
    {
        type = "logistic-container",
        name = "warehouse-logistics",
        icon = "__base__/graphics/icons/logistic-chest-storage.png",
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = 2, result = "warehouse-logistics"},
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
        logistic_mode = "storage",
        vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
        picture =
        {
            filename = "__base__/graphics/icons/logistic-chest-storage.png",
            priority = "extra-high",
            width = 38,
            height = 32,
            scale = 3,
            shift = {0.3, 0}
        },
        circuit_wire_max_distance = 7.5
    },
})
