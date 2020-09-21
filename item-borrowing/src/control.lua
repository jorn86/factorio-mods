local function parse_item(parameter)
    local recipe = string.match(parameter, '%[recipe=(.*)%]')
    local item = string.match(parameter, '%[item=(.*)%]')
    if recipe ~= nil then
        local prototype = game.recipe_prototypes[recipe]
        if prototype ~= nil then
            for _, product in pairs(prototype.products) do
                if product.type == 'item' then
                    return product.name
                end
            end
        end
    elseif item ~= nil then
        local prototype = game.item_prototypes[item]
        return prototype.name
    end
    return parameter
end

local function borrow(player, amount, item)
    local prototype = game.item_prototypes[item]
    if prototype == nil then
        player.print({'item-borrowing.invalid-item', item})
        return
    end

    if amount == nil or amount <= 0 then
        amount = prototype.stack_size
    end
    local inserted = player.insert({count = amount, name = item})

    if global.borrowed[player.index] == nil then
        global.borrowed[player.index] = {}
    end

    local registry = global.borrowed[player.index]
    if registry[item] == nil then
        registry[item] = inserted
    else
        registry[item] = registry[item] + inserted
    end
    player.print({'item-borrowing.borrow-success', inserted, item})
end

local function borrow_command(event)
    if (event.player_index == nil or event.parameter == nil) then return end
    local player = game.players[event.player_index]
    player.print(event.parameter)
    local amount, item = string.match(event.parameter, '(%d*)%s*(.*)')
    borrow(player, tonumber(amount), parse_item(item))
end

local function print_items(text, items, empty)
    if items ~= nil then
        for item, amount in pairs(items) do
            if amount > 0 then
                table.insert(text, {'', {'item-borrowing.item', amount, item}, ','})
            end
        end
    end

    local total_count = #text
    if total_count == 2 then
        return { empty }
    elseif total_count > 21 then
        text = {table.unpack(text, 1, 20)}
        table.insert(text, {'item-borrowing.more', total_count - 20})
    else
        text[#text] = text[#text][2]
    end
    return text
end

local function debt_command(event)
    local player = game.players[event.player_index]
    local text = {'', {'item-borrowing.debt'}}
    text = print_items(text, global.borrowed[event.player_index], 'item-borrowing.no-debt')
    player.print(text)
end

local function pay_command(event)
    local player = game.players[event.player_index]
    local inventory = player.get_main_inventory()
    local removed = {}
    local loan = global.borrowed[event.player_index]
    if loan ~= nil then
        for item, amount in pairs(loan) do
            if amount > 0 then
                local actual = inventory.remove({count = amount, name = item})
                if actual > 0 then
                    removed[item] = actual
                    loan[item] = loan[item] - actual
                end
            end
        end
    end
    print(serpent.line(removed))
    local text = {'', {'item-borrowing.paid'}}
    text = print_items(text, removed, 'item-borrowing.pay-failed')
    player.print(text)
end

commands.add_command('borrow', {'item-borrowing.borrow-command'}, borrow_command)
commands.add_command('debt', {'item-borrowing.debt-command'}, debt_command)
commands.add_command('pay', {'item-borrowing.pay-command'}, pay_command)

script.on_init(function()
    global.borrowed = {}
end)
