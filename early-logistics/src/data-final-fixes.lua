local difficult_technologies = {
    "utility-science-pack",
    "production-science-pack",
    "space-science-pack",
    "se-rocket-science-pack"
}

local function removePacks(name)
    local tech = data.raw.technology[name]
    if not tech then
        log(name .. ' does not exist')
        return
    end

    for i, item in pairs(tech.unit.ingredients) do
        log(name .. ' ingredient ' .. i .. ':' .. item[1])
    end

    for i = #tech.unit.ingredients, 1, -1 do
        local ingredient = tech.unit.ingredients[i][1]
        for _, difficult in pairs(difficult_technologies) do
            if ingredient == difficult then
                log ('Removing ingredient ' .. i .. ': ' .. ingredient .. ' from ' .. name)
                table.remove(tech.unit.ingredients, i)
            end
        end
    end

    if tech.prerequisites then
        for i, prereq in pairs(tech.prerequisites) do
            log(name .. ' prerequisite ' .. i .. ':' .. prereq)
        end

        for i = #tech.prerequisites, 1, -1 do
            local prereq = tech.prerequisites[i]
            for _, difficult in pairs(difficult_technologies) do
                if prereq == difficult then
                    log ('Removing prerequisite ' .. i .. ':' .. prereq .. ' from ' .. name)
                    table.remove(tech.prerequisites, i);
                end
            end
        end
    end
end

removePacks('logistic-robotics')
removePacks('logistic-system')
