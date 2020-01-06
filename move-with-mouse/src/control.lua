local function get_config(player_index)
    if global.targets[player_index] == nil then
        global.targets[player_index] = {
            player_index = player_index
        }
    end
    return global.targets[player_index]
end

local function clear_sprites(config)
    if config.sprites then
        for _,s in pairs(config.sprites) do
            rendering.destroy(s)
        end
        config.sprites = {}
    end
end

local function draw_target(player, position)
    local size = 0.3
    return {
        rendering.draw_circle{
            color = { r = 0, g = 1, b = 0, },
            radius = size / 1.5,
            width = 1,
            filled = false,
            target = position,
            surface = player.surface,
            players = { player },
            draw_on_ground = false,
        },
        rendering.draw_line{
            color = { r = 0, g = 1, b = 0, },
            width = 1,
            from = { x = position.x - size, y = position.y },
            to = { x = position.x + size, y = position.y },
            surface = player.surface,
            players = { player },
            draw_on_ground = false,
        },
        rendering.draw_line{
            color = { r = 0, g = 1, b = 0, },
            width = 1,
            from = { x = position.x, y = position.y - size },
            to = { x = position.x, y = position.y + size },
            surface = player.surface,
            players = { player },
            draw_on_ground = false,
        },
    }
end

local function get_direction(from, to, distance)
    local dx = from.x - to.x
    local dy = from.y - to.y
    if dx > distance then
        -- west
        if dy > distance then
            return defines.direction.northwest
        elseif dy < -distance then
            return defines.direction.southwest
        else
            return defines.direction.west
        end
    elseif dx < -distance then
        -- east
        if dy > distance then
            return defines.direction.northeast
        elseif dy < -distance then
            return defines.direction.southeast
        else
            return defines.direction.east
        end
    else
        -- north/south
        if dy > distance then
            return defines.direction.north
        elseif dy < -distance then
            return defines.direction.south
        end
    end
    return nil
end

local function get_riding_state(v, o, t)
    local radians = o * 2*math.pi
    local angle = radians + math.pi / 2
    local perp_angle = radians

    local v1 = { x = t.x-v.x, y = t.y-v.y }
    local dir = v1.x * math.sin(angle) - v1.y * math.cos(angle)
    local acc = v1.x * math.sin(perp_angle) - v1.y * math.cos(perp_angle)

    local res = {}
    if dir < -0.2 then
        res.dir = defines.riding.direction.left
    elseif dir > 0.2 then
        res.dir = defines.riding.direction.right
    else
        res.dir = defines.riding.direction.straight
    end

    if v1.x*v1.x + v1.y*v1.y < 2 then -- brake when mouse over vehicle
        res.acc = defines.riding.acceleration.braking
    elseif acc < -0.2 then
        res.acc = defines.riding.acceleration.reversing
    elseif acc > 0.2 then
        res.acc = defines.riding.acceleration.accelerating
    else
        res.acc = defines.riding.acceleration.braking
    end

    return {direction = res.dir, acceleration = res.acc}
end

local function reset_cursor(player, config)
    if player.clean_cursor() and config.last_item ~= nil then
        local inventory = player.get_main_inventory()
        player.cursor_stack.set_stack{name=config.last_item, count=inventory.remove{name=config.last_item, count=game.item_prototypes[config.last_item].stack_size}}
        config.last_item = nil
    end
end

script.on_event("mm-move", function(e)
    local config = get_config(e.player_index)
    local player = game.players[e.player_index]
    if player.cursor_stack.valid_for_read then
        if player.cursor_stack.name == "mm-target" then
            reset_cursor(player, config)
            return
        else
            config.last_item = player.cursor_stack.name
            if not player.clean_cursor() then
                return
            end
        end
    end
    player.cursor_stack.set_stack("mm-target")
end)

script.on_event(defines.events.on_player_used_capsule, function(e)
    if e.item.name ~= "mm-target" then return end
    local config = get_config(e.player_index)
    local player = game.players[e.player_index]
    clear_sprites(config)
    config.target = e.position
    config.sprites = draw_target(player, e.position)
    local setting = player.driving and "mm-drive" or "mm-walk"
    if player.mod_settings[setting].value == "hold" then
        player.cursor_stack.set_stack("mm-target")
    else
        reset_cursor(player, config)
    end
end)

script.on_event(defines.events.on_tick, function()
    for _, config in pairs(global.targets) do
        local player = game.players[config.player_index]
        if config.target and player and player.valid then
            if player.driving then
                if get_direction(player.position, config.target, 6) then
                    player.riding_state = get_riding_state(player.vehicle.position, player.vehicle.orientation, config.target)
                else
                    player.riding_state = { direction = defines.riding.direction.straight, acceleration = defines.riding.acceleration.braking }
                    clear_sprites(config)
                    config.target = nil
                end
            else
                local direction = get_direction(player.position, config.target, 0.5)
                if direction then
                    player.walking_state = { walking = true, direction = direction }
                else
                    clear_sprites(config)
                    config.target = nil
                end
            end
        end
    end
end)

script.on_init(function()
    global.targets = {}
end)
