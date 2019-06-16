local function contains(list, value)
    for _,v in pairs(list) do
        if v == value then return true end
    end
    return false
end

local function containsAll(packs, ingredients)
    for _,ingredient in pairs(ingredients) do
        if (not contains(packs, ingredient.name)) then return false end
    end
    return true
end

script.on_init(function()
    local packs = {}
    for _,name in pairs({'automation-science-pack', 'logistic-science-pack', 'chemical-science-pack', 'military-science-pack'}) do
        if (settings.global['quickstart-tech-'..name].value) then
            table.insert(packs, name)
        end
    end

    for _,tech in pairs(game.forces['player'].technologies) do
        if (tech.enabled and containsAll(packs, tech.research_unit_ingredients)) then
            tech.researched = true
        end
    end
end)
