local items = require("items")
local order = 99;

data:extend({
    {
        type = "bool-setting",
        name = "quickstart-clear",
        default_value = true,
        order = "order000",
        setting_type = "runtime-global"
    }, {
        type = "bool-setting",
        name = "quickstart-respawn",
        default_value = false,
        order = "order001",
        setting_type = "runtime-global"
    }
})

for _, item in pairs(items) do
    order = order + 1;
    if mods[item.mod] then
        data:extend({
            {
                type = "int-setting",
                name = "quickstart-" .. item.item,
                localised_name = item.localised_name,
                default_value = item.default,
                minimum_value = 0,
                maximum_value = 9999,
                order = "order" .. order,
                setting_type = "runtime-global"
            }
        })
    end
end
