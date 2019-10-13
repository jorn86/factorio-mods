return {{
    pop_min = 200,
    pop_max = 2000,
    requirements = {
        { old = "hw-wheat", count = 1 },
        { new = "firearm-magazine", count = 0.1 },
    },
    upgrade_rewards = {
        { name = "heavy-armor", count = 1 },
        { name = "combat-shotgun", count = 1 },
        { name = "shotgun-shell", count = 200 },
        { name = "military-science-pack", count = 100 },
    }
}, {
    pop_min = 1600,
    pop_max = 4000,
    requirements = {
        { old = "hw-wheat", new = "hw-bread", count = 1 },
        { old = "firearm-magazine", count = 0.1 },
    },
    upgrade_rewards = {
        { name = "hw-portal", count = 1 },
        { name = "modular-armor", count = 1 },
        { name = "night-vision-equipment", count = 1 },
        { name = "exoskeleton-equipment", count = 1 },
        { name = "battery-equipment", count = 2 },
        { name = "solar-panel-equipment", count = 9 },
    }
}, {
    pop_min = 3500,
    pop_max = 8000,
    requirements = {
        { old = "hw-bread", count = 1 },
        { new = "hw-furniture", count = 0.1 },
        { old = "firearm-magazine", new = "piercing-rounds-magazine", count = 0.1 },
    },
    upgrade_rewards = {
        { name = "tank", count = 1 },
        { name = "cannon-shell", count = 100 },
        { name = "poison-capsule", count = 50 },
        { name = "slowdown-capsule", count = 50 },
    }
}, {
    pop_min = 7000,
    pop_max = 12000,
    requirements = {
        { old = "hw-bread", count = 1 },
        { old = "hw-furniture", count = 0.2 },
        { old = "piercing-rounds-magazine", count = 0.1 },
        { new = "hw-beer-barrel", count = 0.1 },
        { new = "grenade", count = 0.05 },
    },
    upgrade_rewards = {
        { name = "power-armor", count = 1 },
        { name = "fusion-reactor-equipment", count = 1 },
        { name = "energy-shield-equipment", count = 2 },
        { name = "personal-laser-defense-equipment", count = 2 },
    }
}, {
    pop_min = 10000,
    pop_max = 18000,
    requirements = {
        { old = "hw-bread", new = "hw-meal", count = 1 },
        { old = "hw-furniture", count = 0.2 },
        { old = "piercing-rounds-magazine", new = "defender-capsule", count = 0.1 },
        { old = "hw-beer-barrel", count = 0.1 },
        { old = "grenade", count = 0.05 },
    },
    upgrade_rewards = {
        { name = "artillery-turret", count = 1 },
        { name = "artillery-targeting-remote", count = 1 },
        { name = "artillery-wagon", count = 1 },
        { name = "artillery-shell", count = 20 },
    }
}, {
    pop_min = 16000,
    pop_max = 30000,
    requirements = {
        { old = "hw-meal", count = 1 },
        { old = "hw-furniture", count = 0.2 },
        { old = "defender-capsule", count = 0.1 },
        { old = "hw-beer-barrel", count = 0.1 },
        { old = "grenade", count = 0.05 },
        { new = "hw-building-materials", count = 0.04 },
    },
    upgrade_rewards = {
        { name = "power-armor-mk2", count = 1 },
        { name = "fusion-reactor-equipment", count = 1 },
        { name = "energy-shield-mk2-equipment", count = 4 },
        { name = "battery-mk2-equipment", count = 4 },
    }
}, {
    pop_min = 25000,
    pop_max = 50000,
    requirements = {
        { old = "hw-meal", count = 1 },
        { old = "hw-furniture", count = 0.2 },
        { old = "defender-capsule", new = "distractor-capsule", count = 0.1 },
        { old = "hw-beer-barrel", count = 0.1 },
        { old = "grenade", new = "cluster-grenade", count = 0.01 },
        { old = "hw-building-materials", count = 0.04 },
        { new = "hw-wine-barrel", count = 0.05 },
        { new = "hw-electronics", count = 0.04 },
    },
    upgrade_rewards = {
        { name = "space-science-pack", count = 2000 },
    }
}, {
    pop_min = 42000,
    requirements = {
        { old = "hw-meal", count = 1 },
        { old = "hw-furniture", count = 0.2 },
        { old = "distractor-capsule", count = 0.1 },
        { old = "hw-beer-barrel", count = 0.1 },
        { old = "cluster-grenade", count = 0.01 },
        { old = "hw-building-materials", count = 0.04 },
        { old = "hw-wine-barrel", count = 0.05 },
        { old = "hw-electronics", count = 0.04 },
    },
    recurring_rewards = {
        { name = "space-science-pack", count = 0.02 },
    }
}}
