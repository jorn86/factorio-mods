local highestBeltSpeed = function()
    local fastest
    for _,v in pairs(data.raw["transport-belt"]) do
        if (not fastest or fastest.speed < v.speed and v.speed < 1) then fastest = v end
    end
    return fastest.speed
end

local name = "bf-loader"

local entity = table.deepcopy(data.raw.loader["express-loader"])
entity.name = name
entity.speed = highestBeltSpeed()
entity.minable = { mining_time = 0.2, result = nil }
entity.order = "zz"
table.insert(entity.flags, "not-blueprintable")
data.raw.loader[name] = entity
