local config = require("scripts.tier_config")
require('scripts.utility')

return {
    update_stockpile_combinator = function(combinator)
        local parameters = {}
        local i = 1
        for name, count in pairs(get_homeworld(combinator.force).stockpile) do
            table.insert(parameters, { signal = { type = "item", name = name }, count = count, index = i })
            i = i + 1
        end
        combinator.get_or_create_control_behavior().parameters = {parameters = parameters} -- yes, this is weird but right
    end,

    update_status_combinator = function(combinator)
        local hw = get_homeworld(combinator.force)
        local parameters = {
            { signal = { type = "virtual", name = "signal-T" }, count = hw.tier, index = 1 },
            { signal = { type = "virtual", name = "signal-P" }, count = hw.population, index = 2 },
            { signal = { type = "virtual", name = "signal-D" }, count = config.get_current_config(hw).pop_min, index = 3 }
        }
        if config.get_current_config(hw).pop_max then
            table.insert(parameters, { signal = { type = "virtual", name = "signal-U" }, count = config.get_current_config(hw).pop_max, index = 4 })
        end
        combinator.get_or_create_control_behavior().parameters = {parameters = parameters} -- yes, this is weird but right
    end,

    update_requirements_combinator = function(combinator)
        local parameters = {}
        local hw = get_homeworld(combinator.force)
        for i, r in pairs(config.get_current_config(hw).requirements) do
            table.insert(parameters, { signal = { type = "item", name = r.new or r.old }, count = r.count * hw.population, index = i })
        end
        combinator.get_or_create_control_behavior().parameters = {parameters = parameters} -- yes, this is weird but right
    end,
}
