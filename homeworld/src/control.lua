local combinator = require("scripts.combinator")
local farm = require("scripts.farm")
local fishery = require("scripts.fishery")
local portal = require("scripts.homeworld")
local config = require("scripts.tier_config")
local upgrade = require("scripts.version_upgrade")
require("scripts.updater")

local portal_updater = register_updater("hw-portal", portal.update_portal, true);
local updaters = {
    register_updater("hw-requirements-combinator", combinator.update_requirements_combinator),
    register_updater("hw-status-combinator", combinator.update_status_combinator),
    register_updater("hw-stockpile-combinator", combinator.update_stockpile_combinator),
    register_updater_with_beacon("hw-farm", farm.update),
    register_updater_with_beacon("hw-fishery", fishery.update),
}

local function init()
    global.homeworld = {}
    for _,u in pairs(updaters) do
        u.on_init()
    end
    portal.spawn()
end

local function on_built(event)
    portal_updater.on_built(event.created_entity or event.entity)
    for _,u in pairs(updaters) do
        u.on_built(event.created_entity or event.entity)
    end
end

local function on_destroy(event)
    portal_updater.on_destroy(event.entity)
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
        portal_updater.update_all()
        if event.tick % 25000 == 0 then
            portal.next_day()
        end
    end
    for _,u in pairs(updaters) do
        u.update_all()
    end
end

script.on_init(init)
script.on_nth_tick(2500, on_update_portal)
script.on_event(defines.events.on_player_created, portal.on_new_player)
script.on_event(defines.events.on_built_entity, on_built)
script.on_event(defines.events.on_robot_built_entity, on_built)
script.on_event(defines.events.script_raised_built, on_built)
script.on_event(defines.events.on_player_mined_entity, on_destroy)
script.on_event(defines.events.on_robot_mined_entity, on_destroy)
script.on_event(defines.events.on_entity_died, on_destroy)
script.on_event(defines.events.script_raised_destroy, on_destroy)
script.on_event(defines.events.on_tick, on_tick)
script.on_configuration_changed(upgrade)

commands.add_command("hw", {"homeworld-reloaded.command"}, portal.command)
commands.add_command("homeworld", {"homeworld-reloaded.command"}, portal.command)
commands.add_command("hwreset", {"homeworld-reloaded.resetcommand"}, function(event)
    local player = game.players[event.player_index]
    if not player.admin then
        return
    end

    local force = player.force.name
    if event.parameter == "full" then
        global.homeworld[force] = nil
    elseif event.parameter == "stockpile" then
        global.homeworld[force].stockpile = {}
    end
    portal_updater.on_reinit()
    for _, updater in pairs(updaters) do
        updater.on_reinit()
    end
end)

remote.add_interface("homeworld", config)
