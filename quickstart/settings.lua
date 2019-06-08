local order = 99;

local function vanilla(name, default, resourceGroup)
    order = order + 1;
    return {
        type = "int-setting",
        name = "quickstart-" .. name,
        localised_name = { resourceGroup .. "-name." .. name},
        default_value = default,
        minimum_value = 0,
        maximum_value = 9999,
        order = "order" .. order,
        setting_type = "runtime-global"
    }
end

local function mod(modname, name, resourceGroup)
    order = order + 1;
    return {
        type = "int-setting",
        name = "quickstart-" .. modname .. "-" .. name,
        localised_name = {"", {"dependency-" .. modname}, " ", {resourceGroup .. "-name." .. name}},
        default_value = 0,
        minimum_value = 0,
        maximum_value = 9999,
        order = "order" .. order,
        setting_type = "runtime-global"
    }
end

data:extend({
    {
        type = "bool-setting",
        name = "quickstart-clear",
        default_value = true,
        order = "order000",
        setting_type = "runtime-global"
    },
    {
        type = "bool-setting",
        name = "quickstart-respawn",
        default_value = false,
        order = "order001",
        setting_type = "runtime-global"
    },

    vanilla("modular-armor", 1, "item"),
    vanilla("power-armor", 0, "item"),
    vanilla("power-armor-mk2", 0, "item"),
    vanilla("solar-panel-equipment", 10, "equipment"),
    vanilla("fusion-reactor-equipment", 0, "equipment"),
    vanilla("night-vision-equipment", 1, "equipment"),
    vanilla("exoskeleton-equipment", 0, "equipment"),
    vanilla("belt-immunity-equipment", 1, "equipment"),
    vanilla("battery-equipment", 0, "equipment"),
    vanilla("battery-mk2-equipment", 3, "equipment"),
    vanilla("personal-roboport-equipment", 0, "equipment"),
    vanilla("personal-roboport-mk2-equipment", 1, "equipment"),
    vanilla("construction-robot", 25, "entity"),
    vanilla("iron-plate", 0, "item"),
    vanilla("copper-plate", 0, "item"),
    vanilla("transport-belt", 400, "entity"),
    vanilla("underground-belt", 20, "entity"),
    vanilla("splitter", 10, "entity"),
    vanilla("pipe", 50, "entity"),
    vanilla("pipe-to-ground", 10, "entity"),
    vanilla("boiler", 2, "entity"),
    vanilla("steam-engine", 4, "entity"),
    vanilla("offshore-pump", 1, "entity"),
    vanilla("small-electric-pole", 50, "entity"),
    vanilla("medium-electric-pole", 0, "entity"),
    vanilla("big-electric-pole", 0, "entity"),
    vanilla("landfill", 0, "item"),
    vanilla("burner-mining-drill", 20, "entity"),
    vanilla("electric-mining-drill", 20, "entity"),
    vanilla("stone-furnace", 50, "entity"),
    vanilla("steel-furnace", 0, "entity"),
    vanilla("burner-inserter", 0, "entity"),
    vanilla("inserter", 100, "entity"),
    vanilla("long-handed-inserter", 0, "entity"),
    vanilla("fast-inserter", 0, "entity"),
    vanilla("lab", 0, "entity"),
    vanilla("radar", 0, "entity"),
    vanilla("pistol", 0, "item"),
    vanilla("submachine-gun", 0, "item"),
    vanilla("gun-turret", 0, "entity"),
    vanilla("firearm-magazine", 0, "item"),
    vanilla("piercing-rounds-magazine", 0, "item"),
    vanilla("cliff-explosives", 0, "item"),
    vanilla("car", 0, "entity"),
})

if mods["aai-industry"] then
    data:extend({
        mod("aai-industry", "glass", "item"),
        mod("aai-industry", "burner-turbine", "entity"),
        mod("aai-industry", "small-iron-electric-pole", "entity"),
        mod("aai-industry", "burner-lab", "entity")
    })
end