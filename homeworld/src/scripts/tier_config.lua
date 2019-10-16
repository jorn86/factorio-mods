local mode = settings.startup["hw-mode"].value
local military = require("scripts.tier_config_military")
local standard = require("scripts.tier_config_standard")
require("scripts.utility")

local function validate_requirements(i, requirements, allow_new)
    if type(requirements) ~= "table" then
        return i .. ".requirements expected table, was " .. type(requirements)
    end
    for j, r in pairs(requirements) do
        if type(r.count) ~= "number" then
            return i .. ".requirements[" .. j .. "].count expected number, was " .. type(r.count)
        end
        if not allow_new then
            if type(r.old) ~= "string" then
                return i .. ".requirements[" .. j .. "].old expected item name, was " .. type(r.old)
            end
        else
            if not (r.old or r.new) then
                return i .. ".requirements[" .. j .. "].must specify at least .old or .new"
            end
            if r.old and type(r.old) ~= "string" then
                return i .. ".requirements[" .. j .. "].old expected item name, was " .. type(r.old)
            end
            if r.new and type(r.new) ~= "string" then
                return i .. ".requirements[" .. j .. "].new expected item name, was " .. type(r.new)
            end
        end
    end
end

local function validate_config(config)
    local ni = 1
    local pop_min = 100
    local pop_max = 1100
    local last = false
    for i, tier in pairs(config) do
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
        if tier.pop_max then
            local error = validate_requirements(i, tier.requirements, true)
            if error then return error end
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
            local error = validate_requirements(i, tier.requirements, false)
            if error then return error end
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
    print("config validated")
end

local config = standard
if mode == "military" then
    config = military
end

local message = validate_config(config)
if message then error(message) end

return {
    get_status = function()
        return global.homeworld
    end,

    get_config = function()
        return config
    end,

    get_current_config = function()
        return config[global.homeworld.tier]
    end,

    set_config = function(modname, new_config)
        local error = validate_config(new_config)
        if error ~= nil then return error end
        config = new_config
        to_all_players({ "homeworld-reloaded.config-updated", modname })
    end
}
