return {{
    pop_min = 200,
    pop_max = 2000,
    requirements = {
        { old = "hw-wheat", count = 1 },
        { new = "raw-fish", count = 0.5 },
    },
    upgrade_rewards = {
        { name = "electric-furnace", count = 10 },
        { name = "logistic-science-pack", count = 400 },
    }
}, {
    pop_min = 1600,
    pop_max = 4000,
    requirements = {
        { old = "hw-wheat", new = "hw-bread", count = 1 },
        { old = "raw-fish", count = 0.5 },
    },
    upgrade_rewards = {
        { name = "hw-portal", count = 1 },
        { name = "hw-sawmill", count = 10 },
        { name = "chemical-science-pack", count = 100 },
    }
}, {
    pop_min = 3500,
    pop_max = 8000,
    requirements = {
        { old = "hw-bread", count = 1 },
        { old = "raw-fish", count = 0.5 },
        { new = "hw-furniture", count = 0.1 },
    },
    upgrade_rewards = {
        { name = "hw-brewery", count = 10 },
        { name = "solar-panel", count = 50 },
        { name = "chemical-science-pack", count = 400 },
    }
}, {
    pop_min = 7000,
    pop_max = 12000,
    requirements = {
        { old = "hw-bread", count = 1 },
        { old = "raw-fish", count = 0.5 },
        { old = "hw-furniture", count = 0.2 },
        { new = "hw-beer-barrel", count = 0.1 },
    },
    upgrade_rewards = {
        { name = "assembling-machine-3", count = 10 },
        { name = "production-science-pack", count = 400 },
        { name = "utility-science-pack", count = 400 },
    }
}, {
    pop_min = 10000,
    pop_max = 18000,
    requirements = {
        { old = "hw-bread", new = "hw-meal", count = 1 },
        { old = "hw-furniture", count = 0.2 },
        { old = "hw-beer-barrel", count = 0.1 },
    },
    upgrade_rewards = {
        { name = "assembling-machine-3", count = 20 },
        { name = "production-science-pack", count = 400 },
        { name = "utility-science-pack", count = 400 },
    }
}, {
    pop_min = 16000,
    pop_max = 30000,
    requirements = {
        { old = "hw-meal", count = 1 },
        { old = "hw-furniture", count = 0.2 },
        { old = "hw-beer-barrel", count = 0.1 },
        { new = "hw-building-materials", count = 0.04 },
        { new = "crude-oil-barrel", count = 0.01 },
    },
    upgrade_rewards = {
        { name = "production-science-pack", count = 1000 },
        { name = "utility-science-pack", count = 1000 },
    }
}, {
    pop_min = 25000,
    pop_max = 50000,
    requirements = {
        { old = "hw-meal", count = 1 },
        { old = "hw-furniture", count = 0.2 },
        { old = "hw-beer-barrel", count = 0.1 },
        { old = "hw-building-materials", count = 0.04 },
        { old = "crude-oil-barrel", count = 0.01 },
        { new = "hw-wine-barrel", count = 0.05 },
        { new = "hw-electronics", count = 0.04 },
    },
    upgrade_rewards = {
        { name = "space-science-pack", count = 1000 },
    }
}, {
    pop_min = 42000,
    requirements = {
        { old = "hw-meal", count = 1 },
        { old = "hw-furniture", count = 0.2 },
        { old = "hw-beer-barrel", count = 0.1 },
        { old = "hw-building-materials", count = 0.04 },
        { old = "crude-oil-barrel", count = 0.01 },
        { old = "hw-wine-barrel", count = 0.05 },
        { old = "hw-electronics", count = 0.04 },
    },
    recurring_rewards = {
        { name = "space-science-pack", count = 0.02 },
    }
}}
