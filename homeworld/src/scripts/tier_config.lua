local mode = settings.startup["hw-mode"].value
local bob = require("scripts.tier_config_bob")
local military = require("scripts.tier_config_military")
local standard = require("scripts.tier_config_standard")
local standard2 = require("scripts.tier_config_standard-v2")
require("scripts.utility")

local function validate_requirements(i, requirements, allow_new)
    if type(requirements) ~= "table" then
        return i .. ".requirements expected table, was " .. type(requirements)
    end
    for j, r in pairs(requirements) do
        if type(r) ~= "table" then
            return i .. ".requirements[" .. j .. "] expected table, was " .. type(r)
        end
        if type(r.count) ~= "number" then
            return i .. ".requirements[" .. j .. "].count expected number, was " .. type(r.count)
        end
        if not allow_new then
            if type(r.old) ~= "string" then
                return i .. ".requirements[" .. j .. "].old expected item name, was " .. type(r.old)
            elseif game.item_prototypes[r.old] == nil then
                return i .. ".requirements[" .. j .. "].old item " .. r.old .. " does not exist"
            end
        else
            if not (r.old or r.new) then
                return i .. ".requirements[" .. j .. "].must specify at least .old or .new"
            end
            if r.old then
                if type(r.old) ~= "string" then
                    return i .. ".requirements[" .. j .. "].old expected item name, was " .. type(r.old)
                elseif game.item_prototypes[r.old] == nil then
                    return i .. ".requirements[" .. j .. "].old item " .. r.old .. " does not exist"
                end
            end
            if r.new then
                if type(r.new) ~= "string" then
                    return i .. ".requirements[" .. j .. "].new expected item name, was " .. type(r.new)
                elseif game.item_prototypes[r.new] == nil then
                    return i .. ".requirements[" .. j .. "].old item " .. r.new .. " does not exist"
                end
            end
        end
    end
end

local function validate_rewards(prefix, rewards)
    for j, r in pairs(rewards) do
        if type(r) ~= "table" then
            return prefix .. "[" .. j .. "] rewards expected table, was " .. type(r)
        end
        if type(r.name ~= "string") then
            return prefix .. "[" .. j .. "].name expected string, was " .. type(r.name)
        elseif game.item_prototypes[r.name] == nil then
            return prefix .. "[" .. j .. "].name item " .. r.name .. " does not exist"
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
            else
                validate_rewards(i .. ".upgrade_rewards", tier.upgrade_rewards)
            end
            if tier.recurring_rewards ~= nil then
                return i .. ".recurring_rewards is only available as last tier"
            end
        else
            local error = validate_requirements(i, tier.requirements, false)
            if error then return error end
            if type(tier.recurring_rewards) ~= "table" then
                return i .. ".recurring_rewards expected table, was " .. type(tier.upgrade_rewards)
            else
                validate_rewards(i .. ".recurring_rewards", tier.recurring_rewards)
            end
            if tier.upgrade_rewards ~= nil then
                return i .. ".upgrade_rewards is not available on last tier, use recurring_rewards instead"
            end
            last = true
        end
        ni = ni + 1
    end
    if not last then
        return "missing last tier config with recurring rewards"
    end
    print("Homeworld config validated")
end

local config = standard2
if mode == "bob" then
    config = bob
elseif mode == "military" then
    config = military
elseif mode == "standard" then
    config = standard
end

local message = validate_config(config)
if message then error(message) end

local function validate_items_i(cfg)
    for _, tier in pairs(cfg) do
        for _, r in pairs(tier.requirements) do
            if r.old ~= nil and game.item_prototypes[r.old] == nil then
                return r.old
            end
            if r.new ~= nil and game.item_prototypes[r.new] == nil then
                return r.new
            end
        end
        if tier.upgrade_rewards then
        else
            for _, r in pairs(tier.recurring_rewards) do
                if r.name ~= nil and game.item_prototypes[r.name] == nil then
                    return r.name
                end
            end
        end
    end
end

return {
    get_config = function()
        return config
    end,

    get_current_config = function(homeworld)
        return config[homeworld.tier]
    end,

    validate = function()
        local msg = validate_config(config)
        if msg then error(msg) end
    end,
}
