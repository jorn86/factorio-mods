require "defines"

local function insert(player, name, count)
    player.insert{name = name, count = count }
end

local function allinserts(player)
    insert(player, "wood", 100)
    insert(player, "coal", 1000)
    insert(player, "iron-plate", 1000)
    insert(player, "copper-plate", 1000)
    insert(player, "steel-plate", 1000)

    insert(player, "offshore-pump", 5)
    insert(player, "boiler", 14)
    insert(player, "steam-engine", 10)
    insert(player, "pipe", 200)
    insert(player, "pipe-to-ground", 50)

    insert(player, "medium-electric-pole", 50)

    insert(player, "lab", 20)
    insert(player, "science-pack-1", 200)
    insert(player, "science-pack-2", 200)

    insert(player, "assembling-machine-1", 10)
    insert(player, "assembling-machine-2", 10)

    insert(player, "tank", 1)
    insert(player, "piercing-bullet-magazine", 200)
    insert(player, "explosive-cannon-shell", 200)
end

script.on_init(function()
    pcall(function()
        allinserts(game.player)
    end)
end)

script.on_event(defines.events.on_player_created, function(event)
    pcall(function()
        allinserts(game.get_player(event.player_index))
    end)
end)
