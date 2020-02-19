data:extend({
    {
        type = "bool-setting",
        name = "hw-print",
        default_value = true,
        setting_type = "runtime-per-user",
    },
    {
        type = "bool-setting",
        name = "hw-wood",
        default_value = true,
        setting_type = "startup",
    },
    {
        type = "string-setting",
        name = "hw-mode",
        default_value = "standard-v2",
        allowed_values = { "standard", "standard-v2", "military", "bob" },
        setting_type = "startup",
    },
})
