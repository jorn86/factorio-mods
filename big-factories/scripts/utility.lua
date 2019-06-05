function baseValue(box)
    -- consistency between data and control stage is hard :(
    if (box['left_top']) then return baseValue({ { box.left_top.x, box.left_top.y } , { box.right_bottom.x, box.right_bottom.y } } ) end

    local baseValue = box[2][1]
    if (box[1][1] ~= -baseValue) then error('inconsistent box top left: expected ' .. tostring(-baseValue) .. ' actual ' , box[1][1]) end
    if (box[1][2] ~= -baseValue) then error('inconsistent box top right: expected ' .. tostring(-baseValue) .. ' actual ' , box[1][2]) end
    if (box[2][2] ~= baseValue) then error('inconsistent box bottom right: expected ' .. tostring(baseValue) .. ' actual ' , box[2][2]) end
    return baseValue
end

function floorArea(box)
    return {
        left_top = {
            x = math.floor(box.left_top.x),
            y = math.floor(box.left_top.y)
        },
        right_bottom = {
            x = math.floor(box.right_bottom.x + 0.99),
            y = math.floor(box.right_bottom.y + 0.99)
        }
    }
end

function areaWithOffset(box, position, offset)
    return {
        left_top = {
            x = box.left_top.x + position.x - offset,
            y = box.left_top.y + position.y - offset
        },
        right_bottom = {
            x = box.right_bottom.x + position.x + offset,
            y = box.right_bottom.y + position.y + offset
        }
    }
end

function findTechThatUnlocks(recipeName)
    for _, tech in pairs(data.raw.technology) do
        if (tech.effects) then
            for _, effect in pairs(tech.effects) do
                if (effect.type == "unlock-recipe" and effect.recipe == recipeName) then
                    return tech
                end
            end
        end
    end
    print('no recipe found for ' .. recipeName)
    error()
end

function clearArea(center, surface)
    local area = {{center.x-8.8,center.y-8.8},{center.x+8.8,center.y+8.8}}
    -- Ensures factory won't overlap with resources or cliffs
    for _, entity in pairs(surface.find_entities(area)) do
        if entity.valid and entity.type ~= "tree" and entity.type ~= "simple-entity" then
            return false
        end
    end

    -- If only obstacle is trees, remove the trees
    for _, entity in pairs(surface.find_entities(area)) do
        if entity.valid and (entity.type == "tree" or entity.type == "simple-entity") then
            entity.destroy()
        end
    end
    return true
end
