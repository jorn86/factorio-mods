local mode = settings.startup["hw-mode"].value
local military = require("scripts.tier_config_military")
local standard = require("scripts.tier_config_standard")

local function validate_config(config)
    local ni = 1
    local pop_min = 100
    local pop_max = 1100
    local last = false                for i, tier in pairs(config) do
        if i ~= ni then
            return "config table must be a continuous list of tiers"
        end
        if last then
            return "cannot have more tiers after tier with no pop_max and recurring rewards"
        end
        if type(tier.pop_min) ~= "number" then
            return i .. ".pop_min expected number, was " .. type(tier.pop_min)
        end
        if tier.pop_min <= pop_min then
            return i .. ".pop_min must increase from previous tier (starting at 100)"
        end
        if type(tier.requirements) ~= "table" then
            return i .. ".requirements expected table, was " .. type(tier.requirements)
        end
        if tier.pop_max then
            if type(tier.pop_max) ~= "number" then
                return i .. ".pop_max expected number, was " .. type(tier.pop_max)
            end
            if tier.pop_max <= pop_max or tier.pop_max <= tier.pop_min then
                return i .. ".pop_max must increase from both pop_min and previous tier's pop_max (starting at 1100)"
            end
            if type(tier.upgrade_rewards) ~= "table" then
                return i .. ".upgrade_rewards expected table, was " .. type(tier.requirements)
            end
            if tier.recurring_rewards ~= null then
                return i .. ".recurring_rewards is only available as last tier"
            end
        else
            if type(tier.recurring_rewards) ~= "table" then
                return i .. ".recurring_rewards expected table, was " .. type(tier.upgrade_rewards)
            end
            if tier.upgrade_rewards ~= null then
                return i .. ".upgrade_rewards is not available on last tier, use recurring_rewards instead"
            end
            last = true
        end
        ni = ni + 1
    end
    if not last then
        return "missing last tier config with recurring rewards"
    end
end

local config = standard
if mode == "military" then
    config = military
end

validate_config(config)

return {
    get_status = function()
        return global.homeworld
    end,

    get_config = function()
        return config
    end,

    set_config = function(modname, new_config)
        local error = validate_config(new_config)
        if error ~= nil then return error end
        config = new_config
        to_all_players({ "homeworld-reloaded.config-updated", modname })
    end
}
