local items = require("items")
local clear = settings.global["quickstart-clear"].value

local function add(config)
    for _, item in pairs(items) do
        if game.active_mods[item.mod] then
            local amount = settings.global["quickstart-" .. item.item].value
            if amount > 0 then
                config[item.item] = amount
            end
        end
    end
    return config
end

local function call(field)
    local config = {}
    if not clear then
        config = remote.call("freeplay", "get_" .. field)
    end
    remote.call("freeplay", "set_" .. field, add(config))
end

script.on_init(function()
    call("created_items")
    if settings.global["quickstart-respawn"].value then
        call("respawn_items")
    end
end)
