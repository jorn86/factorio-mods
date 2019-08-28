data:extend({
    {
        type = "item",
        name = "ftl-research-satellite",
        icon = "__base__/graphics/icons/satellite.png",
        icon_size = 32,
        subgroup = "intermediate-product",
        order = "z-d[ftl-research-satellite]",
        stack_size = 1,
        rocket_launch_product = {"ftl-science-pack", 1000}
    },
    {
        type = "tool",
        name = "ftl-science-pack",
        icon = "__improved-ftl__/graphics/items/ftl-science.png",
        icon_size = 32,
        subgroup = "science-pack",
        order = "g[ftl-science-pack]",
        stack_size = 2000,
        durability = 1,
        durability_description_key = "description.science-pack-remaining-amount-key",
        durability_description_value = "description.science-pack-remaining-amount-value",
    },
    {
        type = "recipe",
        name = "ftl-research-satellite",
        energy_required = 5,
        enabled = false,
        category = "crafting",
        ingredients =
        {
            {"space-thruster", 1},
            {"fuel-cell", 1},
        },
        result= "ftl-research-satellite",
        requester_paste_multiplier = 1
    },
})