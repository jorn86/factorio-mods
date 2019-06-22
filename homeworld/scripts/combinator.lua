require("scripts.utility")
local settings = require("scripts.tier_config")

local function update_stockpile_combinator(combinator)
    local parameters = {}
    local i = 1
    for name,count in pairs(global.homeworld.stockpile) do
        table.insert(parameters, { signal = { type = "item", name = name }, count = count, index = i })
        i = i + 1
    end
    combinator.get_or_create_control_behavior().parameters = {parameters = parameters} -- yes, this is weird but right
end

local function update_status_combinator(combinator)
    local parameters = {}
    table.insert(parameters, { signal = { type = "virtual", name = "signal-T" }, count = global.homeworld.tier, index = 1 })
    table.insert(parameters, { signal = { type = "virtual", name = "signal-P" }, count = global.homeworld.population, index = 2 })
    table.insert(parameters, { signal = { type = "virtual", name = "signal-D" }, count = settings[global.homeworld.tier].pop_min, index = 3 })
    if settings[global.homeworld.tier].pop_max then
        table.insert(parameters, { signal = { type = "virtual", name = "signal-U" }, count = settings[global.homeworld.tier].pop_max, index = 4 })
    end
    combinator.get_or_create_control_behavior().parameters = {parameters = parameters} -- yes, this is weird but right
end

local function update_requirements_combinator(combinator)
    local parameters = {}
    for i,r in pairs(settings[global.homeworld.tier].requirements) do
        table.insert(parameters, { signal = { type = "item", name = r.name }, count = r.count * global.homeworld.population, index = i })
    end
    combinator.get_or_create_control_behavior().parameters = {parameters = parameters} -- yes, this is weird but right
end

return {
    on_built = function(entity)
        if entity.name == "hw-requirements-combinator" then
            entity.operable = false
            update_requirements_combinator(entity)
        elseif entity.name == "hw-status-combinator" then
            entity.operable = false
            update_status_combinator(entity)
        elseif entity.name == "hw-stockpile-combinator" then
            entity.operable = false
            update_stockpile_combinator(entity)
        end
    end,

    update = function()
        for_all_entities("hw-requirements-combinator", update_requirements_combinator)
        for_all_entities("hw-stockpile-combinator", update_stockpile_combinator)
        for_all_entities("hw-status-combinator", update_status_combinator)
    end,
}
