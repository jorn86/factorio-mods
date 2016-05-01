local function insert(player, name, count)
    player.insert{name = name, count = count }
end

local function insertRail(player)
    insert(player, "diesel-locomotive", 5)
    insert(player, "cargo-wagon", 10)
    insert(player, "straight-rail", 1000)
    insert(player, "curved-rail", 200)
    insert(player, "train-stop", 10)
    insert(player, "rail-signal", 100)
    insert(player, "rail-chain-signal", 100)
end

local function insertScience(player)
    insert(player, "lab", 10)
    insert(player, "science-pack-1", 1000)
    insert(player, "science-pack-2", 500)
    --    insert(player, "science-pack-3", 200)
    --    insert(player, "science-pack-4", 200)
end

local function insertCombat(player)
    insert(player, "submachine-gun", 1)
    insert(player, "tank", 1)
    insert(player, "piercing-bullet-magazine", 400)
    insert(player, "cannon-shell", 200)
    --    insert(player, "explosive-cannon-shell", 200)
end

local function insertRocket(player)
    insert(player, "steel-chest", 6)
    insert(player, "fast-inserter", 6)
    insert(player, "rocket-silo", 1)
    insert(player, "rocket-fuel", 1000)
    insert(player, "rocket-control-unit", 1000)
    insert(player, "low-density-structure", 1000)
    insert(player, "satellite", 1)
    insert(player, "speed-module-3", 4)
end

function allInserts(player)
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

    insert(player, "assembling-machine-1", 10)
    insert(player, "assembling-machine-2", 10)

--    insertCombat(player)
--    insertScience(player)
    insertRail(player)
--    insertRocket(player)
end
