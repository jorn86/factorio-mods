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
    {
        type = "shortcut",
        name = "bf-loader-tool",
        action = "create-blueprint-item",
        item_to_create = "bf-loader-tool",
        icon = { filename = "__base__/graphics/icons/loader.png", size = 32 },
    },
    {
        type = "selection-tool",
        name = "bf-loader-tool",
        icon = "__base__/graphics/icons/loader.png",
        icon_size = 32,
        subgroup = "other",
        order = "bf-zzz",
        stack_size = 1,
        stackable = false,
        flags = { "hidden", "only-in-cursor" },
        selection_mode = { "any-entity", },
        entity_filters = { }, -- filled in data-final-fixes with all big factory entities
        selection_cursor_box_type = "entity",
        selection_color = { r = 0, g = 1, b = 0 },
        alt_selection_mode = { "any-entity", },
        alt_entity_filters = { "bf-loader" },
        alt_selection_cursor_box_type = "entity",
        alt_selection_color = { r = 1, g = 0, b = 0 },
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
