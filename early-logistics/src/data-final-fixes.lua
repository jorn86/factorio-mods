local function removeUtility(name)
    local tech = data.raw.technology[name]

    for i, item in pairs(tech.unit.ingredients) do
        if item[1] == 'utility-science-pack' then
            table.remove(tech.unit.ingredients, i)
        end
    end

    for i, prereq in pairs(tech.prerequisites) do
        if prereq == 'utility-science-pack' then
            tech.prerequisites[i] = 'chemical-science-pack'
        end
    end
end

removeUtility('logistic-robotics')
removeUtility('logistic-system')
