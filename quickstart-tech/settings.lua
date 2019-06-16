local order = 99

local function sciencePack(itemName, default)
    order = order + 1
    return {
        type = "bool-setting",
        name = "quickstart-tech-" .. itemName,
        localised_name = {"", {"quickstart-tech.unlock"}, " ", {"item-name." .. itemName}},
        default_value = default,
        order = "quickstart-tech-" .. order,
        setting_type = "runtime-global"
    }
end

data:extend({
    sciencePack('automation-science-pack', true),
    sciencePack('logistic-science-pack', false),
    sciencePack('chemical-science-pack', false),
    sciencePack('military-science-pack', false),
})
