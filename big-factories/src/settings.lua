data:extend({
    {
        type = "bool-setting",
        name = "bf-minable",
        default_value = false,
        setting_type = "startup",
        order = "bf-00"
    },
    {
        type = "bool-setting",
        name = "bf-craftable",
        default_value = false,
        setting_type = "startup",
        order = "bf-01"
    },
    {
        type = "bool-setting",
        name = "bf-centrifuge-in-assembler",
        default_value = true,
        setting_type = "startup",
        order = "bf-10"
    },
    {
        type = "bool-setting",
        name = "bf-scale-icon",
        default_value = true,
        setting_type = "startup",
        order = "bf-20"
    },
    {
        type = "int-setting",
        name = "bf-speed-factor",
        default_value = 40,
        minimum_value = 1,
        maximum_value = 100,
        setting_type = "startup",
        order = "bf-30"
    },
    {
        type = "int-setting",
        name = "bf-size-factor",
        default_value = 5,
        minimum_value = 1,
        maximum_value = 7,
        setting_type = "startup",
        order = "bf-31"
    },
    {
        type = "int-setting",
        name = "bf-module-slots",
        default_value = 4,
        minimum_value = -1,
        maximum_value = 12,
        setting_type = "startup",
        order = "bf-40"
    },

    {
        type = "bool-setting",
        name = "bf-spawn",
        default_value = true,
        setting_type = "runtime-global",
        order = "bf-00"
    },
    {
        type = "double-setting",
        name = "bf-spawn-chance",
        default_value = 0.04,
        minimum_value = 0,
        maximum_value = 1,
        setting_type = "runtime-global",
        order = "bf-01"
    },
    {
        type = "bool-setting",
        name = "bf-indestructible",
        default_value = true,
        setting_type = "runtime-global",
        order = "bf-02"
    },
    {
        type = "bool-setting",
        name = "bf-loaders",
        default_value = true,
        setting_type = "runtime-global",
        order = "bf-10"
    },
    {
        type = "bool-setting",
        name = "bf-suppress-loaders",
        default_value = true,
        setting_type = "runtime-global",
        order = "bf-11"
    },
})
