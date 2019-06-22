local combinator = require("scripts.combinator")
local farm = require("scripts.farm")
local fishery = require("scripts.fishery")
local portal = require("scripts.homeworld")

local function spawn(position)
    local surface = game.get_surface(1)
    if surface.can_place_entity{name="hw-portal", position=position, force="player", build_check_type=defines.build_check_type.ghost_place} then
        local entity = surface.create_entity{name="hw-portal", position=position, force="player"}
        if entity ~= nil then
            return true
        end
    end
    return false
end

local function init()
    global.homeworld = {
        tier = 1,
        max_tier = 1,
        population = 1000,
        max_population = 1000,
        stockpile = {},
    }
    if spawn({ -5, -5}) then return end
    if spawn({ -5,  5}) then return end
    if spawn({  5,  5}) then return end
    if spawn({  5, -5}) then return end
end

local function on_built(event)
    local entity = event.created_entity
    combinator.on_built(entity)
    farm.on_built(entity)
    fishery.on_built(entity)
end

local function on_destroy(event)
    local entity = event.entity
    farm.on_destroy(entity)
    fishery.on_destroy(entity)
end

script.on_init(init)

script.on_event(defines.events.on_built_entity, on_built)
script.on_event(defines.events.on_robot_built_entity, on_built)
script.on_event(defines.events.on_player_mined_entity, on_destroy)
script.on_event(defines.events.on_robot_mined_entity, on_destroy)
script.on_event(defines.events.on_entity_died, on_destroy)
script.on_event(defines.events.on_player_created, function(event)
    portal.on_new_player(game.get_player(event.player_index))
end)

script.on_nth_tick(300, function(event)
    if (event.tick % 600 == 0) then
        fishery.update()
    else
        farm.update()
    end
end)
script.on_nth_tick(2500, function(event)
    if event.tick == 0 then
        portal.first_day()
    else
        portal.update()
        if event.tick % 25000 == 0 then
            portal.next_day()
        end
    end

    combinator.update()
end)

commands.add_command("hw", {"homeworld-reloaded.command"}, portal.command)
commands.add_command("homeworld", {"homeworld-reloaded.command"}, portal.command)
