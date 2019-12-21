function find(array, element, picker)
    for _,v in pairs(array) do
        if picker(v) == element then return v end
    end
    return nil
end

function get_homeworld(force)
    hw = global.homeworld[force.name]
    if hw == nil then
        print('creating homeworld for ' .. force.name)
        hw = {
            tier = 1,
            max_tier = 1,
            population = 1000,
            max_population = 1000,
            stockpile = {},
        }
        global.homeworld[force.name] = hw
    end
    return hw
end

function fill_beacon(beacon, fertility)
    if not (beacon and beacon.valid) then return end
    local pollution = beacon.surface.get_pollution(beacon.position)
    local modules = beacon.get_module_inventory()
    local increase = math.floor(fertility - (pollution * 3))
    if increase > 0 and (modules.get_item_count("hw-polluted-module") ~= 0 or modules.get_item_count("hw-fertile-module") ~= increase) then
        modules.clear()
        modules.insert({ name = "hw-fertile-module", count = increase })
    elseif increase < 0 and (modules.get_item_count("hw-polluted-module") ~= -increase or modules.get_item_count("hw-fertile-module") ~= 0) then
        modules.clear()
        modules.insert({ name = "hw-polluted-module", count = -increase })
    end
end

function areaWithOffset(position, offset)
    return {
        left_top = {
            x = position.x - offset,
            y = position.y - offset
        },
        right_bottom = {
            x = position.x + offset,
            y = position.y + offset
        }
    }
end

function for_all_entities(name, consumer)
    for _, surface in pairs(game.surfaces) do
        for _, entity in pairs(surface.find_entities_filtered{ name=name}) do
            if entity.valid then consumer(entity) end
        end
    end
end

function to_player(player, message, forced)
    if forced or player.mod_settings["hw-print"].value then
        player.print(message)
    end
end

function to_all_players(force, message, forced)
    for _, player in pairs((force or game).players) do
        to_player(player, message, forced)
    end
end
