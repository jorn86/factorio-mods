data:extend({
    {
        type = "string-setting",
        name = "mm-walk",
        setting_type = "runtime-per-user",
        order = "mm-01",
        default_value = "click",
        allowed_values = { "click", "hold" }
    },
    {
        type = "string-setting",
        name = "mm-drive",
        setting_type = "runtime-per-user",
        order = "mm-02",
        default_value = "hold",
        allowed_values = { "click", "hold" }
    },
    {
        type = "int-setting",
        name = "mm-resettimeout",
        setting_type = "runtime-per-user",
        order = "mm-03",
        minimum_value = 1,
        default_value = 5,
        maximum_value = 60
    },
})
