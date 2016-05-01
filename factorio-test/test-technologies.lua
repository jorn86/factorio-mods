local function unlock(tech)
    tech.researched = true
end

local function onlyRed(tech)
    for _, ingredient in pairs(tech.research_unit_ingredients) do
        if ingredient["name"] == "science-pack-2" or ingredient["name"] == "science-pack-3" or ingredient["name"] == "science-pack-4" then
            return false
        end
    end
    return true
end

local function onlyRedAndGreen(tech)
    for _, ingredient in pairs(tech.research_unit_ingredients) do
        if ingredient["name"] == "science-pack-3" or ingredient["name"] == "science-pack-4" then
            return false
        end
    end
    return true
end

local function unlockConditional(techs, condition)
    for _, tech in pairs(techs) do
        if condition(tech) then
            unlock(tech)
        end
    end
end

function allUnlocks(player)
    local techs = player.force.technologies
--    unlockConditional(techs, onlyRed)
    unlockConditional(techs, onlyRedAndGreen)
--    unlockConditional(techs, function() return true end)
end
