local function removePacks(name)
    local tech = data.raw.technology[name]
    if not tech then
        print(name .. ' does not exist')
        return
    end

    for i, item in pairs(tech.unit.ingredients) do
        if item[1] == 'utility-science-pack' then
            table.remove(tech.unit.ingredients, i)
        end
        if item[1] == 'production-science-pack' then
            table.remove(tech.unit.ingredients, i)
        end
    end

    if tech.prerequisites then
        for i, prereq in pairs(tech.prerequisites) do
            if prereq == 'utility-science-pack' then
                tech.prerequisites[i] = 'chemical-science-pack'
            end
            if prereq == 'production-science-pack' then
                tech.prerequisites[i] = 'chemical-science-pack'
            end
        end
    end
end

removePacks('logistic-robotics')
removePacks('logistic-system')
