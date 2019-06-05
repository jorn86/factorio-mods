data:extend({
    {
        type = "recipe-category",
        name = "big-factory"
    },
    {
        type = "item",
        name = "bf-big-building",
        icon = "__big-factories__/graphics/icons/big-building.png",
        icon_size = 32,
        subgroup = "intermediate-product",
        order = "z-d[ftl-research-satellite]",
        stack_size = 1,
    },
    {
        type = "recipe",
        name = "bf-big-building",
        enabled = false,
        category = "advanced-crafting",
        energy_required = 60,
        ingredients =
        {
            {"concrete", 1000},
            {"steel-plate", 200},
            {"medium-electric-pole", 20},
        },
        result = "bf-big-building",
    },
})

if (settings.startup["bf-craftable"].value) then
    data:extend({
        {
            type = "technology",
            name = "bf-construction",
            icon = "__big-factories__/graphics/technology/big-building.png",
            icon_size = 128,
            prerequisites = {"automation-3", "advanced-oil-processing", "advanced-material-processing-2", "logistics-3"},
            effects =
            {
                {
                    type = "unlock-recipe",
                    recipe = "bf-big-building"
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
