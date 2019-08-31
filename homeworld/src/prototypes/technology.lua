data:extend({
    {
        type = "technology",
        name = "hw-fishing",
        icon = "__base__/graphics/icons/fish.png",
        icon_size = 32,
        effects = {
            { type = "unlock-recipe", recipe = "hw-fishery" },
            { type = "unlock-recipe", recipe = "hw-fish" },
        },
        unit = {
            count = 50,
            ingredients = {
                { "automation-science-pack", 1 },
            },
            time = 15
        }
    },
    {
        type = "technology",
        name = "hw-farming",
        icon = "__homeworld-reloaded__/graphics/icons/wheat.png",
        icon_size = 32,
        effects = {
            { type = "unlock-recipe", recipe = "hw-farm" },
            { type = "unlock-recipe", recipe = "hw-wheat" },
        },
        unit = {
            count = 10,
            ingredients = {
                { "automation-science-pack", 1 },
            },
            time = 15
        }
    },
    {
        type = "technology",
        name = "hw-bread",
        icon = "__homeworld-reloaded__/graphics/icons/bread.png",
        icon_size = 32,
        prerequisites = { "hw-farming" },
        effects = {
            { type = "unlock-recipe", recipe = "hw-bread" },
        },
        unit = {
            count = 80,
            ingredients = {
                { "automation-science-pack", 1 },
            },
            time = 15
        }
    },
    {
        type = "technology",
        name = "hw-hops-farming",
        icon = "__homeworld-reloaded__/graphics/icons/hops.png",
        icon_size = 32,
        prerequisites = { "hw-farming" },
        effects = {
            { type = "unlock-recipe", recipe = "hw-hops" },
        },
        unit = {
            count = 100,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
            },
            time = 30
        }
    },
    {
        type = "technology",
        name = "hw-veg-farming",
        icon = "__homeworld-reloaded__/graphics/icons/veg.png",
        icon_size = 32,
        prerequisites = { "hw-farming" },
        effects = {
            { type = "unlock-recipe", recipe = "hw-veg" },
        },
        unit = {
            count = 100,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
            },
            time = 30
        }
    },
    {
        type = "technology",
        name = "hw-grape-farming",
        icon = "__homeworld-reloaded__/graphics/icons/grapes.png",
        icon_size = 32,
        prerequisites = { "hw-veg-farming", "hw-hops-farming", "production-science-pack" },
        effects = {
            { type = "unlock-recipe", recipe = "hw-grapes" },
        },
        unit = {
            count = 200,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
            },
            time = 60
        }
    },
    {
        type = "technology",
        name = "hw-farm-combined",
        icon = "__homeworld-reloaded__/graphics/icons/farm.png",
        icon_size = 32,
        prerequisites = { "hw-grape-farming", "utility-science-pack" },
        effects = {
            { type = "unlock-recipe", recipe = "hw-farm-combined" },
        },
        unit = {
            count = 1000,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 },
            },
            time = 60
        }
    },

    {
        type = "technology",
        name = "hw-beer",
        icon = "__homeworld-reloaded__/graphics/icons/beer.png",
        icon_size = 32,
        prerequisites = { "hw-hops-farming", "fluid-handling" },
        effects = {
            { type = "unlock-recipe", recipe = "hw-brewery" },
            { type = "unlock-recipe", recipe = "hw-barrel" },
            { type = "unlock-recipe", recipe = "hw-beer-barrel" },
        },
        unit = {
            count = 100,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
            },
            time = 60
        }
    },
    {
        type = "technology",
        name = "hw-meal",
        icon = "__homeworld-reloaded__/graphics/icons/luxury-meal.png",
        icon_size = 32,
        prerequisites = { "hw-fishing", "hw-bread", "hw-veg-farming" },
        effects = {
            { type = "unlock-recipe", recipe = "hw-meal" },
        },
        unit = {
            count = 200,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
            },
            time = 60
        }
    },
    {
        type = "technology",
        name = "hw-wine",
        icon = "__homeworld-reloaded__/graphics/icons/wine.png",
        icon_size = 32,
        prerequisites = { "hw-grape-farming", "fluid-handling" },
        effects = {
            { type = "unlock-recipe", recipe = "hw-brewery" },
            { type = "unlock-recipe", recipe = "hw-barrel" },
            { type = "unlock-recipe", recipe = "hw-wine-barrel" },
        },
        unit = {
            count = 200,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
            },
            time = 60
        }
    },
    {
        type = "technology",
        name = "hw-carpentry",
        icon = "__homeworld-reloaded__/graphics/icons/furniture.png",
        icon_size = 32,
        effects = {
            { type = "unlock-recipe", recipe = "hw-sawmill" },
            { type = "unlock-recipe", recipe = "hw-furniture" },
        },
        unit = {
            count = 200,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
            },
            time = 60
        }
    },
    {
        type = "technology",
        name = "hw-building-materials",
        icon = "__homeworld-reloaded__/graphics/icons/building-materials.png",
        icon_size = 32,
        prerequisites = { "hw-carpentry", "concrete" },
        effects = {
            { type = "unlock-recipe", recipe = "hw-building-materials" },
        },
        unit = {
            count = 200,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
            },
            time = 60
        }
    },
    {
        type = "technology",
        name = "hw-portal",
        icon = "__homeworld-reloaded__/graphics/icons/portal.png",
        icon_size = 32,
        prerequisites = { "electronics" },
        effects = {
            { type = "unlock-recipe", recipe = "hw-portal" },
        },
        unit = {
            count = 100,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
            },
            time = 30
        }
    },
    {
        type = "technology",
        name = "hw-combinator",
        icon = "__base__/graphics/icons/constant-combinator.png",
        icon_size = 32,
        prerequisites = { "hw-portal", "circuit-network" },
        effects = {
            { type = "unlock-recipe", recipe = "hw-requirements-combinator" },
            { type = "unlock-recipe", recipe = "hw-status-combinator" },
            { type = "unlock-recipe", recipe = "hw-stockpile-combinator" },
        },
        unit = {
            count = 100,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
            },
            time = 30
        }
    },
    {
        type = "technology",
        name = "hw-electronics",
        icon = "__homeworld-reloaded__/graphics/icons/electronics.png",
        icon_size = 32,
        prerequisites = { "utility-science-pack" },
        effects = {
            { type = "unlock-recipe", recipe = "hw-electronics" },
        },
        unit = {
            count = 200,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "utility-science-pack", 1 },
            },
            time = 60
        }
    },
})
if settings.startup["hw-wood"].value then
    table.insert(data.raw["technology"]["hw-farming"].effects, { type = "unlock-recipe", recipe = "hw-wood" })
end
