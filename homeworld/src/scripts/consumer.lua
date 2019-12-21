require('scripts.utility')

local function consume(hw, item, amount)
    if not item then return 0 end
    local stock = hw.stockpile[item] or 0
    local to_consume = math.min(stock, amount)
    hw.stockpile[item] = stock - to_consume
    return to_consume
end

local function consume_goals(hw, goals, factor)
    for _, goal in pairs(goals) do
        local remaining = math.floor(goal.required * factor)
        remaining = remaining - consume(hw, goal.new, remaining)
        remaining = remaining - consume(hw, goal.old, remaining)
        if remaining > 0 then
            --print(remaining .. " remaining after consuming " .. serpent.line(goal))
        end
    end
end

return function(hw, requirements)
    local goals = {}
    local min_completion_new = 2
    local min_completion_old = 2
    for _, r in pairs(requirements) do
        local required = math.floor(r.count * hw.population)
        local goal = { new = r.new, old = r.old, required = required }
        if r.new then
            local stock = hw.stockpile[r.new] or 0
            goal.completion_new = math.min(stock / required, 2)
            required = math.max(required - stock, 0)
            min_completion_new = math.min(min_completion_new, goal.completion_new)
        end
        if required > 0 and r.old then
            local stock = hw.stockpile[r.old] or 0
            goal.completion_old = math.min(stock / required, 2)
            min_completion_old = math.min(min_completion_old, goal.completion_old)
        end
        table.insert(goals, goal)
    end

    local population_factor
    if  min_completion_old < 1 then
        consume_goals(hw, goals, 1)
        population_factor = (min_completion_old - 1) * 0.1
    elseif  min_completion_new < 1 then
        consume_goals(hw, goals, 1)
        population_factor = 0
    elseif requirements.pop_max then
        consume_goals(hw, goals, min_completion_new)
        population_factor = (min_completion_new - 1) * 0.1
    else -- last tier, no new requirements
        consume_goals(hw, goals, min_completion_old)
        population_factor = (min_completion_old - 1) * 0.1
    end

    return {
        upgrade_completion = min_completion_new,
        sustain_completion = min_completion_old,
        population_factor = population_factor,
    }
end
