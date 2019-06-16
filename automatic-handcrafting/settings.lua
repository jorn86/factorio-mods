data:extend({
    {
        type = "double-setting",
        name = "ah-target",
        default_value = 0.5,
        minimum_value = 0,
        maximum_value = 10,
        setting_type = "runtime-per-user",
    },
    {
        type = "int-setting",
        name = "ah-interval",
        default_value = 60,
        minimum_value = 10,
        maximum_value = 3600,
        setting_type = "runtime-global",
    },
})
