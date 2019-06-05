data:extend({
    {
        type = "bool-setting",
        name = "bf-minable",
        default_value = false,
        setting_type = "startup",
        order = '01'
    },
    {
        type = "bool-setting",
        name = "bf-craftable",
        default_value = false,
        setting_type = "startup",
        order = '02'
    },
    {
        type = "bool-setting",
        name = "bf-centrifuge-in-assembler",
        default_value = true,
        setting_type = "startup",
        order = '03'
    },
    {
        type = "bool-setting",
        name = "bf-scale-icon",
        default_value = true,
        setting_type = "startup",
        order = '04'
    },
    {
        type = "int-setting",
        name = "bf-speed-factor",
        default_value = 40,
        minimum_value = 1,
        maximum_value = 100,
        setting_type = "startup",
        order = '10'
    },
    {
        type = "int-setting",
        name = "bf-size-factor",
        default_value = 5,
        minimum_value = 1,
        maximum_value = 7,
        setting_type = "startup",
        order = '11'
    },
    {
        type = "int-setting",
        name = "bf-module-slots",
        default_value = 4,
        minimum_value = -1,
        maximum_value = 12,
        setting_type = "startup",
        order = '12'
    },
    {
        type = "bool-setting",
        name = "bf-spawn",
        default_value = true,
        setting_type = "runtime-global",
        order = '00'
    },
    {
        type = "double-setting",
        name = "bf-spawn-chance",
        default_value = 0.04,
        minimum_value = 0,
        maximum_value = 1,
        setting_type = "runtime-global",
        order = '01'
    },
})
