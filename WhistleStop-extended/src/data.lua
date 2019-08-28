if (settings.startup["wsfx-craftable"].value) then
    data:extend({
        {
            type = "item",
            name = "wsfx-big-building",
            icon = "__WhistleStop-extended__/graphics/icons/factory-3.png",
            icon_size = 32,
            subgroup = "intermediate-product",
            order = "z-d[ftl-research-satellite]",
            stack_size = 1,
        },
        {
            type = "recipe",
            name = "wsfx-big-building",
            enabled = false,
            category = "advanced-crafting",
            ingredients =
            {
                {"concrete", 1000},
                {"steel-plate", 200},
                {"medium-electric-pole", 20},
            },
            result = "wsfx-big-building",
        },
        {
            type = "recipe",
            name = "wsfx-big-furnace",
            category = "advanced-crafting",
            enabled = false,
            ingredients =
            {
                {"wsfx-big-building", 1},
                {"electric-furnace", 50},
                {"fast-inserter", 100},
                {"express-transport-belt", 300},
            },
            result = "wsf-big-furnace",
        },
        {
            type = "recipe",
            name = "wsfx-big-assembly",
            category = "advanced-crafting",
            enabled = false,
            ingredients =
            {
                {"wsfx-big-building", 1},
                {"assembling-machine-3", 32},
                {"fast-inserter", 64},
                {"express-transport-belt", 200},
            },
            result = "wsf-big-assembly",
        },
        {
            type = "recipe",
            name = "wsfx-big-refinery",
            category = "advanced-crafting",
            enabled = false,
            ingredients =
            {
                {"wsfx-big-building", 1},
                {"oil-refinery", 18},
                {"pipe", 200},
                {"pipe-to-ground", 200},
                {"pump", 10},
            },
            result = "wsf-big-refinery",
        },
        {
            type = "technology",
            name = "wsfx-construction",
            icon = "__WhistleStop-extended__/graphics/technology/factory-architecture-3.png",
            icon_size = 128,
            prerequisites = {"automation-3", "advanced-oil-processing", "advanced-material-processing-2", "logistics-3"},
            effects =
            {
                {
                    type = "unlock-recipe",
                    recipe = "wsfx-big-building"
                },
                {
                    type = "unlock-recipe",
                    recipe = "wsfx-big-assembly"
                },
                {
                    type = "unlock-recipe",
                    recipe = "wsfx-big-refinery"
                },
                {
                    type = "unlock-recipe",
                    recipe = "wsfx-big-furnace"
                },
            },
            unit =
            {
                count = 1000,
                ingredients =
                {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1}
                },
                time = 60
            },
        },
    })
end