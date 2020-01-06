require("scripts.utility")
local config = require("scripts.tier_config")
local consume = require("scripts.consumer")

local function mark(player, position, color)
    rendering.draw_circle {
        color = color,
        radius = 0.5,
        width = 2,
        filled = false,
        target = position,
        surface = player.surface,
        players = { player },
        draw_on_ground = false,
        time_to_live = 300
    }
end

local function debug(player)
    local message = { "homeworld-reloaded.debug", table_size(global["hw-portal"]), table_size(global["hw-farm"]), table_size(global["hw-fishery"]) }
    to_player(player, message, true)

    for _, entity in pairs(global["hw-portal"]) do
        if entity.valid then
            mark(player, entity.position, { r = 255, g = 0, b = 255 })
        end
    end
    for _, entity in pairs(global["hw-farm"]) do
        if entity[1].valid then
            mark(player, entity[1].position, { r = 0, g = 255, b = 0 })
        end
    end
    for _, entity in pairs(global["hw-fishery"]) do
        if entity[1].valid then
            mark(player, entity[1].position, { r = 0, g = 0, b = 255 })
        end
    end
    for _, entity in pairs(global["hw-requirements-combinator"]) do
        if entity.valid then
            mark(player, entity.position, { r = 0, g = 255, b = 255 })
        end
    end
    for _, entity in pairs(global["hw-stockpile-combinator"]) do
        if entity.valid then
            mark(player, entity.position, { r = 0, g = 255, b = 255 })
        end
    end
    for _, entity in pairs(global["hw-status-combinator"]) do
        if entity.valid then
            mark(player, entity.position, { r = 0, g = 255, b = 255 })
        end
    end
end

local function print_tier_details(player, tier, forced)
    to_player(player, { "homeworld-reloaded.tier", tier }, forced)
    local message = {}
    for _, r in pairs(config.get_config()[tier].requirements) do
        table.insert(message, ",  ")
        if r.old then
            if r.new then
                table.insert(message, {"homeworld-reloaded.requirement-upgrade", r.count, "[img=item/" .. r.old .. "]", "[img=item/" .. r.new .. "]"})
            else
                table.insert(message, {"homeworld-reloaded.requirement-old", r.count, "[img=item/" .. r.old .. "]"})
            end
        elseif r.new then
            table.insert(message, {"homeworld-reloaded.requirement-new", r.count, "[img=item/" .. r.new .. "]"})
        else
            print("Invalid requirement: " .. serpent.line(r))
        end
    end
    message[1] = ""
    to_player(player, message, forced)
end

local function print_stockpile(player, forced)
    to_player(player, { "homeworld-reloaded.stockpile-contents" }, forced)
    local message = {}
    local hw = get_homeworld(player.force)
    local add = function(item)
        if hw.stockpile[item] then
            table.insert(message, ",  ")
            table.insert(message, tostring(math.floor(hw.stockpile[item])) .. " [img=item/" .. item .. "]")
        end
    end
    for _, r in pairs(config.get_current_config(hw).requirements) do
        add(r.old)
        add(r.new)
    end
    message[1] = ""
    to_player(player, message, forced)
end

local function check_achievements_for(player)
    local hw = get_homeworld(player.force)
    if hw.population >= 25000 then
        player.unlock_achievement("hw-25k")
    end
    if hw.population >= 100000 then
        player.unlock_achievement("hw-100k")
    end
    if hw.population >= 500000 then
        player.unlock_achievement("hw-500k")
    end
end

local function check_achievements(force)
    for _, player in pairs(force.players) do
        check_achievements_for(player)
    end
end

local function take_portal_items(reqs, name, stockpile, inventory, portal, index, property)
    local requirements = find(reqs, name, function(i)
        return i[property]
    end)
    if requirements then
        local current = stockpile[name] or 0
        local max = math.floor(requirements.count * get_homeworld(portal.force).population * 2.5)
        if current < max then
            stockpile[name] = current + inventory[index].count
            local removed = inventory.remove(inventory[index])
            portal.force.item_production_statistics.on_flow(name, -removed)
            return true
        end
    end
    return false
end

local function update_portal(portal)
    local hw = get_homeworld(portal.force)
    local tier_settings = config.get_current_config(hw)
    local stockpile = hw.stockpile
    local inventory = portal.get_inventory(1)
    local any = false
    for index = 1, #inventory do
        if inventory[index] and inventory[index].valid_for_read then
            local name = inventory[index].name
            any = take_portal_items(tier_settings.requirements, name, stockpile, inventory, portal, index,"old") or any
            any = take_portal_items(tier_settings.requirements, name, stockpile, inventory, portal, index, "new") or any
        end
    end
    if any then
        inventory.sort_and_merge()
        portal.surface.create_entity { name = "hw-portal-sound", position = portal.position, force = portal.force, target = portal }
    end
end

local function count_filled_slots(contents)
    local stacks = 0
    for item, count in pairs(contents) do
        stacks = stacks + math.ceil(count / game.item_prototypes[item].stack_size)
    end
    return stacks
end

local function with_portal_for_rewards(force, consumer)
    local best
    local best_empty = 0
    for _, surface in pairs(game.surfaces) do
        for _, portal in pairs(surface.find_entities_filtered { name = "hw-portal", force = force }) do
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
    end

    print("no portals with empty slots found at all")
    return false
end

local function deliver_rewards(force, rewards)
    local success = with_portal_for_rewards(force, function(portal)
        local lost = false
        for _, r in pairs(rewards) do
            if portal.insert({ name = r.name, count = r.count }) < r.count then
                lost = true
            end
        end
        return lost
    end)

    local hw = get_homeworld(force)
    local cfg = config.get_current_config(hw)
    if cfg.pop_max then
        to_all_players(force, { "homeworld-reloaded.tier-up-first", hw.tier, cfg.pop_max }, true)
    else
        to_all_players(force, { "homeworld-reloaded.tier-up-max", hw.tier }, true)
    end
    if not success then
        to_all_players(force, { "homeworld-reloaded.rewards-lost" }, false)
    end
end

local function deliver_repeating_rewards(force, rewards)
    local reward_count = 0
    local hw = get_homeworld(force)
    local success = with_portal_for_rewards(force, function(portal)
        local lost = false
        for _, r in pairs(rewards) do
            reward_count = math.floor(r.count * hw.population)
            if portal.insert({ name = r.name, count = reward_count }) < reward_count then
                lost = true
            end
        end
        return lost
    end)

    to_all_players(force, { "homeworld-reloaded.max-tier-reward", reward_count }, false)
    if not success then
        to_all_players(force, { "homeworld-reloaded.rewards-lost" }, false)
    end
end

local function check_tier_update(force, requirements_for_repeating_met)
    local hw = get_homeworld(force)
    local tier_settings = config.get_current_config(hw)
    if tier_settings.pop_max and hw.population >= tier_settings.pop_max then
        hw.tier = hw.tier + 1
        if hw.max_tier < hw.tier then
            hw.max_tier = hw.tier
            deliver_rewards(force, tier_settings.upgrade_rewards)
            for _, player in pairs(force.players) do
                print_tier_details(player, hw.tier, false)
            end
        elseif config.get_current_config(hw).pop_max then
            to_all_players(force, { "homeworld-reloaded.tier-up", hw.tier, config.get_current_config(hw).pop_max }, false)
        else
            to_all_players(force, { "homeworld-reloaded.tier-up-max", hw.tier }, false)
        end
    elseif hw.tier > 1 and hw.population <= tier_settings.pop_min then
        hw.tier = hw.tier - 1
        to_all_players(force, { "homeworld-reloaded.tier-down", hw.tier, config.get_current_config(hw).pop_min }, false)
    elseif not tier_settings.pop_max and requirements_for_repeating_met then
        deliver_repeating_rewards(force, tier_settings.recurring_rewards)
    end
end

local function update_population(force, consumed)
    local hw = get_homeworld(force)
    local delta = math.floor(consumed.population_factor * hw.population)
    hw.population = hw.population + delta
    if hw.population > hw.max_population then
        hw.max_population = hw.population
    end
    local lower_limit = config.get_config()[1].pop_min
    if consumed.upgrade_completion >= 1 and consumed.sustain_completion >= 1 then
        if delta < 0 then print(serpent.line(consumed)) end
        if config.get_current_config(hw).pop_max then
            to_all_players(force, { "homeworld-reloaded.day-success", math.floor(consumed.upgrade_completion * 100), delta, hw.population }, false)
        else
            to_all_players(force, { "homeworld-reloaded.day-success-max", math.floor(consumed.sustain_completion * 100), delta, hw.population }, false)
        end
    elseif consumed.sustain_completion < 1 then
        if delta > 0 then print(serpent.line(consumed)) end
        if hw.population < lower_limit then
            hw.population = lower_limit
            to_all_players(force, { "homeworld-reloaded.min-pop-reached" }, false)
        else
            to_all_players(force, { "homeworld-reloaded.day-fail", math.floor(consumed.sustain_completion * 100), -delta, hw.population }, false)
        end
    else
        to_all_players(force, { "homeworld-reloaded.day-no-change" , math.floor(consumed.upgrade_completion * 100) }, false)
    end
end

local function on_next_day()
    for _, force in pairs(game.forces) do
        if global.homeworld[force.name] ~= nil then
            local hw = get_homeworld(force)
            local consumed = consume(hw, config.get_current_config(hw).requirements)
            update_population(force, consumed)

            if consumed.sustain_completion >= 1 and consumed.upgrade_completion >= 1 then
                check_achievements(force)
                check_tier_update(force, true)
            else
                check_tier_update(force, false)
            end
        end
    end
end

local function spawn(position)
    local surface = game.get_surface(1)
    if surface.can_place_entity { name = "hw-portal", position = position, force = "player", build_check_type = defines.build_check_type.ghost_place } then
        local entity = surface.create_entity { name = "hw-portal", position = position, force = "player" }
        if entity ~= nil then
            global["hw-portal"] = { entity }
            return true
        end
    end
    return false
end

return {
    on_new_player = function(event)
        local player = game.get_player(event.player_index)
        to_player(player, { "homeworld-reloaded.welcome" }, true)
        to_player(player, { "homeworld-reloaded.command" }, true)
        check_achievements_for(player)
    end,

    first_day = function()
        for _, player in pairs(game.players) do
            print_tier_details(player, 1, false)
        end
    end,

    next_day = on_next_day,
    update_portal = update_portal,

    command = function(event)
        if event.name == "hw" or event.name == "homeworld" then
            local player = game.get_player(event.player_index)
            if event.parameter == nil then
                to_player(player, { "homeworld-reloaded.command" }, true)
            elseif event.parameter:sub(1, 5) == "debug" then
                debug(player)
            elseif event.parameter:sub(1, 5) == "tier " then
                local tier = tonumber(event.parameter:sub(5, event.parameter:len()))
                if config.get_config()[tier] ~= nil then
                    print_tier_details(player, tier, true)
                end
            elseif event.parameter:sub(1, 6) == "status" then
                local hw = get_homeworld(player.force)
                if config.get_current_config(hw).pop_max then
                    to_player(player, { "homeworld-reloaded.status", hw.tier, hw.population,
                                        config.get_current_config(hw).pop_max, hw.max_population }, true)
                else
                    to_player(player, { "homeworld-reloaded.status-max",
                                        hw.tier, hw.population, hw.max_population }, true)
                end
                print_tier_details(player, hw.tier, true)
            elseif event.parameter:sub(1, 5) == "stock" then
                print_stockpile(player, true)
            end
        end
    end,

    spawn = function()
        if spawn({ -5, -5 }) then
            return
        end
        if spawn({ -5, 5 }) then
            return
        end
        if spawn({ 5, 5 }) then
            return
        end
        if spawn({ 5, -5 }) then
            return
        end
    end,
}
