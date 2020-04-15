data:extend({{
    type = "bool-setting",
    name = "bo-remove-fluid-wagon",
    default_value = true,
    setting_type = "startup"
}, {
    type = "bool-setting",
    name = "bo-hide-barrel-recipes",
    default_value = true,
    setting_type = "startup"
}, {
    type = "string-setting",
    name = "bo-barrel-capacity",
    default_value = "50",
    allowed_values = {"10", "20", "50"},
    setting_type = "startup"
}})
