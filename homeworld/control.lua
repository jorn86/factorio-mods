local combinator = require("scripts.combinator")
local farm = require("scripts.farm")
local fishery = require("scripts.fishery")
local portal = require("scripts.homeworld")
require("scripts.updater")

local updaters = {
    register_updater("hw-portal", portal.update_portal),
    register_updater("hw-requirements-combinator", combinator.update_requirements_combinator),
    register_updater("hw-status-combinator", combinator.update_status_combinator),
    register_updater("hw-stockpile-combinator", combinator.update_stockpile_combinator),
    register_updater_with_beacon("hw-farm", farm.update),
    register_updater_with_beacon("hw-fishery", fishery.update),
}

local function init()
    global.homeworld = {
        tier = 1,
        max_tier = 1,
        population = 1000,
        max_population = 1000,
        stockpile = {},
    }
    for _,u in pairs(updaters) do
        u.on_init()
    end
    portal.spawn()
end

local function on_built(event)
    for _,u in pairs(updaters) do
        u.on_built(event.created_entity)
    end
end

local function on_destroy(event)
    for _,u in pairs(updaters) do
        u.on_destroy(event.entity)
    end
end

local function on_tick(event)
    for _,u in pairs(updaters) do
        u.update_single(event)
    end
end

local function on_update_portal(event)
    if event.tick == 0 then
        portal.first_day()
    else
        for _,u in pairs(updaters) do
            u.update_all()
        end
        if event.tick % 25000 == 0 then
            portal.next_day()
        end
    end
end

script.on_init(init)
script.on_nth_tick(2500, on_update_portal)
script.on_event(defines.events.on_player_created, portal.on_new_player)
script.on_event(defines.events.on_built_entity, on_built)
script.on_event(defines.events.on_robot_built_entity, on_built)
script.on_event(defines.events.on_player_mined_entity, on_destroy)
script.on_event(defines.events.on_robot_mined_entity, on_destroy)
script.on_event(defines.events.on_entity_died, on_destroy)
script.on_event(defines.events.on_tick, on_tick)

commands.add_command("hw", {"homeworld-reloaded.command"}, portal.command)
commands.add_command("homeworld", {"homeworld-reloaded.command"}, portal.command)
