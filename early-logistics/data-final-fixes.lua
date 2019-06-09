local function removeUtility(name)
    local tech = data.raw.technology[name]
    local ingredients = tech.unit.ingredients
    local remove = -1
    for i,ingredient in pairs(ingredients) do
        if ingredient[1] == 'utility-science-pack' then remove = i end
    end
    if remove > 0 then
        local removed = table.remove(ingredients, remove)
        if removed[1] ~= 'utility-science-pack' then error() end
    end
end

removeUtility('logistic-system')
if mods['space-exploration'] then
    removeUtility('logistic-robotics')
end
