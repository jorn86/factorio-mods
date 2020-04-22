local timeout = settings.global["tt-timeout"].value

local events = {
    train_teleported = script.generate_event_name()
}

local function print_error(force, position, key)
    force.print({ "", {"train-teleporter.error", position.x, position.y }, " ", key })
    return false
end

local function show_warning(players, entity, key)
    for _, player in pairs(players) do
        player.add_custom_alert(entity, { type = "virtual", name = "tt-signal" }, key, false)
    end
    return true
end

local function find_to_record(schedule, station)
    local from_record = schedule.records[schedule.current]
    if from_record.temporary or from_record.wait_conditions == nil or #from_record.wait_conditions ~= 1 then
        return nil
    end

    local wait_condition = from_record.wait_conditions[1]
    if wait_condition.type ~= "circuit" or wait_condition.condition == nil then
        return nil
    end

    local circuit_condition = wait_condition.condition
    if circuit_condition.first_signal == nil or circuit_condition.first_signal.type ~= "virtual" or circuit_condition.first_signal.name ~= "tt-signal" then
        return nil
    end

    local target = circuit_condition.constant
    if circuit_condition.second_signal ~= nil then
        target = station.get_merged_signal(circuit_condition.second_signal)
    end

    return (schedule.current + target) % #schedule.records + 1
end

local function calculate_rotation(from, to)
    return (8 + from - to) % 8
end

local function offset(from_stop, from_position, to_stop)
    local from_anchor = from_stop.position
    local to_anchor = to_stop.position
    local rotation = calculate_rotation(from_stop.direction, to_stop.direction)
    local dx = from_position.x - from_anchor.x
    local dy = from_position.y - from_anchor.y
    if rotation == 0 then
        return { x = to_anchor.x + dx, y = to_anchor.y + dy }
    elseif rotation == 2 then
        return { x = to_anchor.x + dy, y = to_anchor.y - dx }
    elseif rotation == 4 then
        return { x = to_anchor.x - dx, y = to_anchor.y - dy }
    else -- rotation == 6
        return { x = to_anchor.x - dy, y = to_anchor.y + dx }
    end
end

local function destroy_spawned(new_cars)
    for _, car in pairs(new_cars) do
        car.destroy()
    end
end

local function spawn(train, from_stop, to_stop)
    local new_cars = {}
    for _, car in pairs(train.carriages) do
        local new_car = to_stop.surface.create_entity {
            name = car.name,
            position = offset(from_stop, car.position, to_stop),
            force = to_stop.force,
            raise_built = true,
            direction = to_stop.direction
        }
        if new_car == nil then
            print("Failed to spawn car")
            destroy_spawned(new_cars)
            return true
        end
        table.insert(new_cars, new_car)
    end

    local new_train = new_cars[1].train
    for _, car in pairs(new_cars) do
        if car.train ~= new_train then
            print("Spawn failed to make a single new train")
            destroy_spawned(new_cars)
            return true
        end
    end
    if #train.carriages ~= #new_train.carriages then
        print_error(from_stop.force, from_stop.position, { "train-teleporter.connection-error", to_stop.position.x, to_stop.position.y })
        destroy_spawned(new_cars)
        return false
    end
    return new_cars
end

local function train_is_straight(train)
    local x = train.carriages[1].position.x
    local y = train.carriages[1].position.y
    for _, car in pairs(train.carriages) do
        if car.position.x ~= x and car.position.y ~= y then
            return false
        end
    end
    return true
end

local function copy_inventory(from_car, to_car, inventory_type)
    local from = from_car.get_inventory(inventory_type)
    local to = to_car.get_inventory(inventory_type)
    if from == nil or to == nil then
        return
    end
    for i = 1, #from do
        if from.is_filtered() then
            to.set_filter(i, from.get_filter(i))
        end
        to.insert(from[i])
    end
end

local function copy(from_car, to_car)
    to_car.health = from_car.health
    if from_car.color ~= nil then
        to_car.color = from_car.color
    end
    if from_car.burner ~= nil then
        to_car.burner.currently_burning = from_car.burner.currently_burning
        to_car.burner.remaining_burning_fuel = from_car.burner.remaining_burning_fuel
    end

    for name, amount in pairs(from_car.get_fluid_contents()) do
        to_car.insert_fluid({ name = name, amount = amount})
    end
    copy_inventory(from_car, to_car, defines.inventory.cargo_wagon)
    copy_inventory(from_car, to_car, defines.inventory.burnt_result)
end

local function check(train)
    if not train.valid or not train.state == defines.train_state.wait_station or train.station == nil or not train.station.valid then
        return false
    end

    local from_id = train.id
    local schedule = train.schedule
    local from_stop = train.station
    local force = from_stop.force
    local to_index = find_to_record(schedule, from_stop)
    if to_index == nil then
        return false
    end
    if schedule.current == to_index then
        return print_error(force, from_stop.position, { "train-teleporter.stop-error" })
    end

    local to_record = schedule.records[to_index]
    if to_record.temporary or to_record.station == nil then
        return print_error(force, from_stop.position, { "train-teleporter.invalid-target-error" })
    end

    if #train.passengers > 0 then
        return show_warning(train.passengers, { "train-teleporter.passenger-warning" })
    end

    if not train_is_straight(train) then
        return print_error(force, from_stop.position, { "train-teleporter.position-error" })
    end

    local to_stops = game.get_train_stops({name = to_record.station, force = force})
    if #to_stops == 0 then
        return show_warning(force.players, { "train-teleporter.no-target-warning", to_record.station })
    end
    if #to_stops > 1 then
        return show_warning(force.players, { "train-teleporter.multiple-targets-warning", to_record.station })
    end

    local to_stop = to_stops[1]
    local new_cars = spawn(train, from_stop, to_stop)
    if new_cars == true or new_cars == false then
        return new_cars
    end

    local new_train = new_cars[1].train
    local from_cars = train.carriages
    train.manual_mode = true
    for i = 1, #from_cars do
        local car = from_cars[i]
        copy(car, new_cars[i])
        car.destroy()
    end
    schedule.current = to_index
    new_train.schedule = schedule
    new_train.manual_mode = false
    script.raise_event(events.train_teleported, {
        from = from_id,
        to = new_train.id
    })
end

script.on_init(function()
    global.delayed = {}
end)

script.on_event(defines.events.on_train_changed_state, function(e)
    if check(e.train) then
        table.insert(global.delayed, e.train)
    end
end)

script.on_nth_tick(timeout, function()
    if #global.delayed > 0 then
        print("Checking " .. #global.delayed)
    end

    local check_again = {}
    for _, train in pairs(global.delayed) do
        if check(train) then
            table.insert(check_again, train)
        end
    end
    global.delayed = check_again
end)

remote.add_interface("train-teleporter", {
    get_events = function()
        return events
    end
})
