-- Mostly copied from WhistleStopFactories, except takes non-layered animations into account

-- Scales up visuals by a factor and scales back animations by a factor (to adjust for increased crafting speed)

local function scalePosition(position, factor)
    local x = position.x or position[1]
    local y = position.y or position[2]
    if x and y then
        return {x = x * factor, y = y * factor}
    else
        return position
    end
end

-- Scale graphics by a factor and correct animation speed
local function bumpUp(animation, scaleFactor, animationFactor)
    if type(animation) ~= "table" then
        return
    end
    if type(animation.shift) == "table" then
        animation.shift = scalePosition(animation.shift, scaleFactor)
    end

    animation.scale = (animation.scale or 1) * scaleFactor
    if type(animation.frame_count) == "number" and animation.frame_count > 1 then
        animation.animation_speed = (animation.animation_speed or 1) * animationFactor
    end
end

local function bumpFullAnimation(animation, scaleFactor, animationFactor)
    if type(animation) == "table" then
        bumpUp(animation, scaleFactor, animationFactor)
        bumpUp(animation.hr_version, scaleFactor, animationFactor)
    end
end

local function bumpAllAnimations(animation, scaleFactor, animationFactor)
    if type(animation) == "table" then
        if (type(animation.layers) == "table") then
            for _,v in pairs(animation.layers) do
                --print(serpent.line(v))
                bumpFullAnimation(v, scaleFactor, animationFactor)
            end
        else
            --print(serpent.line(animation))
            bumpFullAnimation(animation, scaleFactor, animationFactor)
        end
    end
end

return function(machine, scaleFactor, animationFactor)
    if type(machine) ~= "table" then
        return
    end

    -- Animation Adjustments
    if type(machine.animation) == "table" then
        bumpAllAnimations(machine.animation.north, scaleFactor, animationFactor)
        bumpAllAnimations(machine.animation.east, scaleFactor, animationFactor)
        bumpAllAnimations(machine.animation.south, scaleFactor, animationFactor)
        bumpAllAnimations(machine.animation.west, scaleFactor, animationFactor)
        bumpAllAnimations(machine.animation, scaleFactor, animationFactor)
    end
    if type(machine.on_animation) == "table" then
        bumpAllAnimations(machine.on_animation, scaleFactor, animationFactor)
    end
    if type(machine.off_animation) == "table" then
        bumpAllAnimations(machine.off_animation, scaleFactor, animationFactor)
    end

    -- Working Visualisations Adjustments
    if type(machine.working_visualisations) == "table" then
        for _,v in pairs(machine.working_visualisations) do
            if type(v) == "table" then
                bumpFullAnimation(v.animation, scaleFactor, animationFactor)
                for _, direction in pairs({"north", "east", "south", "west"}) do
                    bumpFullAnimation(v[direction .. "_animation"], scaleFactor, animationFactor)
                    if type(v[direction .. "_position"]) == "table" then
                        v[direction .. "_position"] = scalePosition(v[direction .. "_position"], scaleFactor)
                    end
                end
            end
        end
    end
end