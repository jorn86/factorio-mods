data:extend({
    {
        type = "recipe",
        name = "woodrecipe",
        category = "crafting-with-fluid",
        enabled = false,
        energy_required = 5,
        ingredients = {
            {"coal", 2},
            {type="fluid", name="water", amount=2},
        },
        result = "raw-wood"
    },
    {
        type = "technology",
        name = "woodtech",
        icon = "__base__/graphics/icons/raw-wood.png",
        effects = {
            {
                type = "unlock-recipe",
                recipe = "woodrecipe"
            }
        },
        prerequisites = {"automation-2"},
        unit = {
            count = 20,
            ingredients = {{"science-pack-1", 2}, {"science-pack-2", 1}},
            time = 10
        }
    },
})
