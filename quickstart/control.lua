local function insert(player, setting, item)
    local amount = settings.global[setting].value
    if (amount > 0) then
        player.insert({name=item, count=amount})
    end
end

local function insertVanilla(player, name)
    insert(player,"quickstart-" .. name, name)
end

local function insertModded(player, mod, name)
    insert(player,"quickstart-" .. mod .. "-" .. name, name)
end

local eventHandler = function(event)
    local p = game.get_player(event.player_index)
    if (settings.global["quickstart-clear"].value) then
        p.get_inventory(defines.inventory.character_main).clear()
        p.get_inventory(defines.inventory.character_guns).clear()
        p.get_inventory(defines.inventory.character_ammo).clear()
        p.get_inventory(defines.inventory.character_armor).clear()
    end

    insertVanilla(p,"modular-armor")
    insertVanilla(p,"power-armor")
    insertVanilla(p,"power-armor-mk2")
    insertVanilla(p,"solar-panel-equipment")
    insertVanilla(p,"fusion-reactor-equipment")
    insertVanilla(p,"night-vision-equipment")
    insertVanilla(p,"exoskeleton-equipment")
    insertVanilla(p,"belt-immunity-equipment")
    insertVanilla(p,"battery-equipment")
    insertVanilla(p,"battery-mk2-equipment")
    insertVanilla(p,"personal-roboport-equipment")
    insertVanilla(p,"personal-roboport-mk2-equipment")
    insertVanilla(p,"construction-robot")
    insertVanilla(p,"iron-plate")
    insertVanilla(p,"copper-plate")
    insertVanilla(p,"transport-belt")
    insertVanilla(p,"underground-belt")
    insertVanilla(p,"splitter")
    insertVanilla(p,"pipe")
    insertVanilla(p,"pipe-to-ground")
    insertVanilla(p,"boiler")
    insertVanilla(p,"steam-engine")
    insertVanilla(p,"offshore-pump")
    insertVanilla(p,"small-electric-pole")
    insertVanilla(p,"medium-electric-pole")
    insertVanilla(p,"big-electric-pole")
    insertVanilla(p,"landfill")
    insertVanilla(p,"burner-mining-drill")
    insertVanilla(p,"electric-mining-drill")
    insertVanilla(p,"stone-furnace")
    insertVanilla(p,"steel-furnace")
    insertVanilla(p,"burner-inserter")
    insertVanilla(p,"inserter")
    insertVanilla(p,"long-handed-inserter")
    insertVanilla(p,"fast-inserter")
    insertVanilla(p,"lab")
    insertVanilla(p,"radar")
    insertVanilla(p,"pistol")
    insertVanilla(p,"submachine-gun")
    insertVanilla(p,"gun-turret")
    insertVanilla(p,"firearm-magazine")
    insertVanilla(p,"piercing-rounds-magazine")
    insertVanilla(p,"cliff-explosives")
    insertVanilla(p,"car")

    if (game.active_mods["aai-industry"]) then
        insertModded(p, "aai-industry", "glass")
        insertModded(p, "aai-industry", "burner-turbine")
        insertModded(p, "aai-industry", "small-iron-electric-pole")
        insertModded(p, "aai-industry", "burner-lab")
    end
end

script.on_event(defines.events.on_player_created, eventHandler)
script.on_event(defines.events.on_player_respawned, function(event)
    if (settings.global["quickstart-respawn"].value) then eventHandler(event) end
end)
