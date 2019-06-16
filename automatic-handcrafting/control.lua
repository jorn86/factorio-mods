local interval = settings.global['ah-interval'].value

local function getState(player)
    if (global.state[player.index] == nil) then
        global.state[player.index] = {}
    end
    return global.state[player.index]
end

local function initSettings(player)
    local state = getState(player)
    state.target = player.mod_settings['ah-target'].value
    player.print({'automatic-handcrafting.setting-initialized', state.target})
end

local function check(player)
    local state = getState(player)
    if player.crafting_queue_size > 1 or state.paused or state.target == 0 then return end

    local inventory = player.get_main_inventory().get_contents()
    for i = 1,100 do
        local item = player.get_quick_bar_slot(i)
        if item then
            local target = item.stack_size * state.target
            if (inventory[item.name] or 0) < target then
                for _,recipe in pairs(game.recipe_prototypes) do
                    if recipe.enabled then
                        for _,product in pairs(recipe.products) do
                            if item.name == product.name then
                                if player.begin_crafting{count=1, recipe=recipe.name, silent=true} > 0 then
                                    state.crafting = true
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

script.on_init(function()
    global.state = {}
end)

script.on_event(defines.events.on_player_created, function(event)
    initSettings(game.get_player(event.player_index))
end)

script.on_event(defines.events.on_tick, function(event)
    if (global.checkImmediately or event.tick % interval == 0) then
        global.checkImmediately = false
        for _,player in pairs(game.players) do
            if player.crafting_queue_size == 0 then
                check(player)
            end
        end
    end
end)

script.on_event(defines.events.on_player_cancelled_crafting, function(event)
    local player = game.get_player(event.player_index)
    local state = getState(player)
    if state.crafting then
        state.paused = true
        player.print({'automatic-handcrafting.auto-disabled'})
    end
end)

script.on_event(defines.events.on_player_crafted_item, function(event)
    local player = game.get_player(event.player_index)
    if player.crafting_queue_size == 1 then
        getState(player).crafting = false
        global.checkImmediately = true -- because calling check() here makes the game crash :(
    end
end)

script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
    initSettings(game.get_player(event.player_index))
end)

script.on_event(defines.events.on_lua_shortcut, function(event)
    local player = game.get_player(event.player_index)
    local state = getState(player)
    if state.paused then
        state.paused = false
        player.print({'automatic-handcrafting.enabled'})
    else
        state.paused = true
        player.print({'automatic-handcrafting.disabled'})
    end
end)
