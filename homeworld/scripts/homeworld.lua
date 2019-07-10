require("scripts.utility")
local settings = require('scripts.tier_config')

local function toPlayer(player, message, forced)
    if forced or player.mod_settings["hw-print"].value then
        player.print(message)
    end
end

local function toAllPlayers(message, forced)
    for _,player in pairs(game.players) do
        toPlayer(player, message, forced)
    end
end

local function printTierDetails(player, tier, forced)
    toPlayer(player, {"homeworld-reloaded.tier", tier}, forced)
    for _,r in pairs(settings[tier].requirements) do
        toPlayer(player,{"", tostring(r.count) .. ' [img=item/' .. r.name .. ']'}, forced)
    end
end

local function update_portal(portal)
    local tier_settings = settings[global.homeworld.tier]
    local stockpile = global.homeworld.stockpile
    local inventory = portal.get_inventory(1)
    local any = false
    for index = 1, #inventory do
        if inventory[index] and inventory[index].valid_for_read then
            local requirements = find(tier_settings.requirements, inventory[index].name, function(i) return i.name end)
            if requirements then
                local current = stockpile[inventory[index].name] or 0
                local max = requirements.count * global.homeworld.population * 2
                if current < max then
                    stockpile[inventory[index].name] = current + inventory[index].count
                    inventory.remove(inventory[index])
                    any = true
                end
            end
        end
    end
    if any then
        inventory.sort_and_merge()
        portal.surface.create_entity{ name = "hw-portal-sound", position = portal.position, force = portal.force, target = portal }
    end
end

local function min_completion(results, skip_new)
    local min = 2
    for _,r in pairs(results) do
        if not skip_new or not r.new then
            if r.completion < min then min = r.completion end
        end
    end
    return min
end

local function update_stockpile(results, factor, skip_new)
    if factor <= 0 then return end
    local tier_settings = settings[global.homeworld.tier]
    local stock = global.homeworld.stockpile
    for _,r in pairs(tier_settings.requirements) do
        local result = results[r.name]
        if not skip_new or not result.new then
            local consumption = factor * result.count * global.homeworld.population
            if consumption < (stock[r.name] or 0) then
                stock[r.name] = stock[r.name] - consumption
            else
                stock[r.name] = 0
            end
        end
    end
end

local function handle_no_change(results)
    local factor = min_completion(results, false)
    update_stockpile(results, 1,true)
    toAllPlayers({ "homeworld-reloaded.day-no-change", math.floor(factor * 100)}, false)
end

local function handle_increase(results)
    local factor = min_completion(results, false)
    update_stockpile(results, math.min(factor, 1.1), false)
    local hw = global.homeworld
    local delta = math.floor((math.min(factor, 1.1) - 1) * hw.population)
    hw.population = hw.population + delta
    if hw.population > (hw.max_population or 0) then
        hw.max_population = hw.population
    end
    toAllPlayers({ "homeworld-reloaded.day-success", math.floor(factor * 100), delta, hw.population}, false)
end

local function handle_decrease(results)
    local factor = min_completion(results, true)
    update_stockpile(results, math.max(factor, 0.9), true)
    local hw = global.homeworld
    local delta = math.floor((math.max(factor, 0.9) - 1) * hw.population)
    local lower_limit = settings[1].pop_min
    if hw.population + delta < lower_limit then
        if hw.population > lower_limit then
            hw.population = lower_limit
            toAllPlayers({ "homeworld-reloaded.min-pop-reached"}, false)
        end
    else
        hw.population = hw.population + delta
        toAllPlayers({ "homeworld-reloaded.day-fail", math.floor(factor * 100), -delta, hw.population}, false)
    end
end

local function count_filled_slots(contents)
    local stacks = 0
    for item, count in pairs(contents) do
        stacks = stacks + math.ceil(count / game.item_prototypes[item].stack_size)
    end
    return stacks
end

local function with_portal_for_rewards(consumer)
    local best
    local best_empty = 0
    for _, surface in pairs(game.surfaces) do
        for _, portal in pairs(surface.find_entities_filtered{ name="hw-portal"}) do
            local inventory = portal.get_inventory(1)

            local empty = #inventory - count_filled_slots(inventory.get_contents())
            if best_empty < empty then
                best = inventory
                best_empty = empty
            end
        end
    end

    if best then
        local bar = best.getbar()
        best.setbar()
        local lost = consumer(best)
        best.sort_and_merge()
        best.setbar(bar)
        return not lost
    else
        print('no portals with empty slots found at all')
    end

    return false
end

local function deliver_rewards(rewards)
    local hw = global.homeworld
    local success = with_portal_for_rewards(function(portal)
        local lost = false
        for _,r in pairs(rewards) do
            if portal.insert({ name = r.name, count = r.count }) < r.count then
                lost = true
            end
        end
        return lost
    end)

    toAllPlayers({ "homeworld-reloaded.tier-up-first", hw.tier, settings[hw.tier].pop_max}, true)
    if not success then
        toAllPlayers({ "homeworld-reloaded.rewards-lost" }, false)
    end
end

local function deliver_repeating_rewards(rewards)
    local hw = global.homeworld
    local reward_count = 0
    local success = with_portal_for_rewards(function(portal)
        local lost = false
        for _,r in pairs(rewards) do
            reward_count = math.floor(r.count * hw.population)
            if portal.insert({ name = r.name, count = reward_count }) < reward_count then
                lost = true
            end
        end
        return lost
    end)

    toAllPlayers({ "homeworld-reloaded.max-tier-reward", reward_count}, false)
    if not success then
        toAllPlayers({ "homeworld-reloaded.rewards-lost" }, false)
    end
end

local function check_tier_update(requirements_for_repeating_met)
    local hw = global.homeworld
    local tier_settings = settings[hw.tier]
    if tier_settings.pop_max and hw.population >= tier_settings.pop_max then
        hw.tier = hw.tier + 1
        if hw.max_tier < hw.tier then
            hw.max_tier = hw.tier
            deliver_rewards(tier_settings.upgrade_rewards)
            for _,player in pairs(game.players) do
                printTierDetails(player, hw.tier, false)
            end
        elseif settings[hw.tier].pop_max then
            toAllPlayers({ "homeworld-reloaded.tier-up", hw.tier, settings[hw.tier].pop_max}, false)
        else
            toAllPlayers({ "homeworld-reloaded.tier-up-max", hw.tier }, false)
        end
    elseif hw.tier > 1 and hw.population <= tier_settings.pop_min then
        hw.tier = hw.tier - 1
        toAllPlayers({ "homeworld-reloaded.tier-down", hw.tier, settings[hw.tier].pop_min}, false)
    elseif not tier_settings.pop_max and requirements_for_repeating_met then
        deliver_repeating_rewards(tier_settings.recurring_rewards)
    end
end

local function on_next_day()
    local tier_settings = settings[global.homeworld.tier]
    local results = {}
    local can_increase = true
    local can_decrease = false
    for _, r in pairs(tier_settings.requirements) do
        local stock = global.homeworld.stockpile[r.name] or 0
        results[r.name] = { name = r.name, new = r.new, count = r.count }
        results[r.name].consumption = r.count * global.homeworld.population
        results[r.name].completion = stock / results[r.name].consumption
        if results[r.name].completion < 1 then
            can_increase = false
            if not r.new then can_decrease = true end
        end
    end

    if can_increase then
        handle_increase(results)
    elseif can_decrease then
        handle_decrease(results)
    else
        handle_no_change(results)
    end

    check_tier_update(can_increase)
end

return {
    update = function()
        for_all_entities("hw-portal", update_portal)
    end,

    on_new_player = function(player)
        toPlayer(player, {"homeworld-reloaded.welcome"}, true)
        toPlayer(player, {"homeworld-reloaded.command"}, true)
    end,

    first_day = function()
        for _,player in pairs(game.players) do
            printTierDetails(player, 1, false)
        end
    end,

    next_day = on_next_day,

    command = function(event)
        if event.name == "hw" or event.name == "homeworld" then
            local player = game.get_player(event.player_index)
            if event.parameter == nil then
                toPlayer(player, {"homeworld-reloaded.command"}, true)
            elseif event.parameter:sub(1, 5) == "tier " then
                local tier = tonumber(event.parameter:sub(5, event.parameter:len()))
                if settings[tier] ~= nil then
                    printTierDetails(player, tier, true)
                end
            elseif event.parameter:sub(1, 2) == "st" then
                if settings[global.homeworld.tier].pop_max then
                    toPlayer(player, {"homeworld-reloaded.status", global.homeworld.tier, global.homeworld.population, settings[global.homeworld.tier].pop_max, global.homeworld.max_population}, true)
                else
                    toPlayer(player, {"homeworld-reloaded.status-max", global.homeworld.tier, global.homeworld.population, global.homeworld.max_population}, true)
                end
                printTierDetails(player, global.homeworld.tier, true)
            end
        end
    end
}
