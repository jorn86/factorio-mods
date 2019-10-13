local config = require("scripts.tier_config")

return {
    update_stockpile_combinator = function(combinator)
        local parameters = {}
        local i = 1
        for name,count in pairs(global.homeworld.stockpile) do
            table.insert(parameters, { signal = { type = "item", name = name }, count = count, index = i })
            i = i + 1
        end
        combinator.get_or_create_control_behavior().parameters = {parameters = parameters} -- yes, this is weird but right
    end,

    update_status_combinator = function(combinator)
        local parameters = {}
        table.insert(parameters, { signal = { type = "virtual", name = "signal-T" }, count = global.homeworld.tier, index = 1 })
        table.insert(parameters, { signal = { type = "virtual", name = "signal-P" }, count = global.homeworld.population, index = 2 })
        table.insert(parameters, { signal = { type = "virtual", name = "signal-D" }, count = config.get_config()[global.homeworld.tier].pop_min, index = 3 })
        if config.get_config()[global.homeworld.tier].pop_max then
            table.insert(parameters, { signal = { type = "virtual", name = "signal-U" }, count = config.get_config()[global.homeworld.tier].pop_max, index = 4 })
        end
        combinator.get_or_create_control_behavior().parameters = {parameters = parameters} -- yes, this is weird but right
    end,

    update_requirements_combinator = function(combinator)
        local parameters = {}
        for i,r in pairs(config.get_config()[global.homeworld.tier].requirements) do
            table.insert(parameters, { signal = { type = "item", name = r.new or r.old }, count = r.count * global.homeworld.population, index = i })
        end
        combinator.get_or_create_control_behavior().parameters = {parameters = parameters} -- yes, this is weird but right
    end,
}
