local function localise(mod, prefix, item)
    local key = prefix and prefix .. "-name." .. item or item
    if mod == nil then
        return { key }
    end
    return { "", {"dependency-" .. mod}, " ", { key }}
end

local function vanilla(item, default, resource_prefix)
    return { mod = "base", item = item, default = default, localised_name = localise(nil, resource_prefix, item) }
end

local function mod(mod_name, item, resource_prefix)
    return { mod = mod_name, item = item, default = 0, localised_name = localise(mod_name, resource_prefix, item) }
end

return {
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
    vanilla("personal-laser-defense-equipment", 0, "equipment"),
    vanilla("construction-robot", 25, "entity"),
    vanilla("iron-plate", 0, "item"),
    vanilla("copper-plate", 0, "item"),
    vanilla("transport-belt", 400, "entity"),
    vanilla("underground-belt", 20, "entity"),
    vanilla("splitter", 10, "entity"),
    vanilla("fast-transport-belt", 0, "entity"),
    vanilla("fast-underground-belt", 0, "entity"),
    vanilla("fast-splitter", 0, "entity"),
    vanilla("assembling-machine-1", 0, "entity"),
    vanilla("assembling-machine-2", 0, "entity"),
    vanilla("pipe", 50, "entity"),
    vanilla("pipe-to-ground", 10, "entity"),
    vanilla("boiler", 2, "entity"),
    vanilla("steam-engine", 4, "entity"),
    vanilla("offshore-pump", 1, "entity"),
    vanilla("small-electric-pole", 50, "entity"),
    vanilla("medium-electric-pole", 0, "entity"),
    vanilla("big-electric-pole", 0, "entity"),
    vanilla("landfill", 0, "item"),
    vanilla("burner-mining-drill", 0, "entity"),
    vanilla("electric-mining-drill", 20, "entity"),
    vanilla("stone-furnace", 50, "entity"),
    vanilla("steel-furnace", 0, "entity"),
    vanilla("electric-furnace", 0, "entity"),
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
    mod("aai-industry", "glass", "item"),
    mod("aai-industry", "burner-turbine", "entity"),
    mod("aai-industry", "small-iron-electric-pole", "entity"),
    mod("aai-industry", "burner-lab", "entity"),
    mod("bobgreenhouse", "bob-greenhouse", "entity"),
    mod("bobplates", "chemical-boiler", "entity"),
    mod("bobplates", "bob-distillery", "entity"),
    mod("bobplates", "electrolyser", "entity"),
    mod("bobplates", "mixing-furnace", "entity"),
    mod("Raven", "raven-1", "item"),
    mod("homeworld-reloaded", "hw-farm", "entity"),
    mod("homeworld-reloaded", "hw-fishery", "entity"),
    mod("homeworld-reloaded", "hw-brewery", "entity"),
    mod("homeworld-reloaded", "hw-sawmill", "entity"),
    mod("homeworld-reloaded", "hw-portal", "entity"),
    mod("Mining_Drones", "mining-drone"),
    mod("Mining_Drones", "mining-depot"),
}
