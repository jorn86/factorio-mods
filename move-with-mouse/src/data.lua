data:extend({
    {
        type = "custom-input",
        name = "mm-move",
        key_sequence = "mouse-button-3",
        action = "lua",
    },
    {
        type = "ammo-category",
        name = "mm",
    },
    {
        type = "capsule",
        name = "mm-target",
        capsule_action = {
            type = "throw",
            attack_parameters = {
                type = "stream",
                range = 999,
                cooldown = 1,
                ammo_type = {
                    category = "mm",
                    target_type = "position",
                },
            },
        },
        flags = { "hidden", "only-in-cursor", },
        stack_size = 1,
        icon = "__move-with-mouse__/graphics/empty.png",
        icon_size = 16,
    }
})
