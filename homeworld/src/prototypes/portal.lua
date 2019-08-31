local function combinator_entity(name)
    local entity = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"])
    entity.name = name
    entity.minable.result = name
    return entity
end

data:extend({
    {
        type = "item-subgroup",
        name = "homeworld",
        group = "production",
        order = "h[homeworld]",
    },
    {
        type = "container",
        name = "hw-portal",
        icon = "__homeworld-reloaded__/graphics/icons/portal.png",
        icon_size = 32,
        flags = { "player-creation", "placeable-player" },
        render_layer = "floor",
        minable = { mining_time = 0.3, result = "hw-portal" },
        max_health = 150,
        corpse = "big-remnants",
        dying_explosion = "medium-explosion",
        collision_box = { { -2.4, -1.9 }, { 2.4, 1.9 } },
        selection_box = { { -2.5, -2.0 }, { 2.5, 2.0 } },
        picture = {
            filename = "__homeworld-reloaded__/graphics/entity/portal/portal.png",
            priority = "low",
            width = 226,
            height = 163,
            shift = { 0.9375, -0.375 }
        },
        circuit_wire_max_distance = 9,
        circuit_wire_connection_point = {
            shadow = {
                red = { 2.4, 2.4 },
                green = { 2.4, 2.4 }
            },
            wire = {
                red = { 2.4, 2.4 },
                green = { 2.4, 2.4 }
            }
        },
        inventory_size = 99,
        open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume = 0.65 },
        close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7 },
    },
    {
        type = "item",
        name = "hw-portal",
        icon = "__homeworld-reloaded__/graphics/icons/portal.png",
        icon_size = 32,
        subgroup = "homeworld",
        place_result = "hw-portal",
        order = "hw-a[portal]",
        stack_size = 1,
    },
    {
        type = "recipe",
        name = "hw-portal",
        enabled = false,
        ingredients = {
            {"stone-brick", 200},
            {"electronic-circuit", 50},
            {"iron-chest", 5}
        },
        result = "hw-portal",
    },
    {
        type = "explosion",
        name = "hw-portal-sound",
        flags = {"not-on-map"},
        animations = {{
            filename = "__core__/graphics/empty.png",
            priority = "extra-high",
            width = 1,
            height = 1,
            frame_count = 1
        }},
        sound = {{
            filename = "__homeworld-reloaded__/sound/portal.ogg",
            volume = 1
        }},
        created_effect = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "create-entity",
                    entity_name = "hw-portal-fx",
                }
            }
        }
    },
    {
        type = "explosion",
        name = "hw-portal-fx",
        flags = {"not-on-map"},
        animations = {{
             filename = "__homeworld-reloaded__/graphics/entity/portal/portal-animation.png",
             priority = "high",
             width = 95,
             height = 215,
             frame_count = 50,
             line_length = 10,
             animation_speed = 0.2,
             shift = { -0.5, -2.375 },
             tint = { r = 1, g = 1, b = 1, a = 1 }
         }},
    },
    combinator_entity("hw-requirements-combinator"),
    {
        type = "item",
        name = "hw-requirements-combinator",
        icon = "__base__/graphics/icons/signal/signal_R.png",
        icon_size = 32,
        subgroup = "homeworld",
        place_result = "hw-requirements-combinator",
        order = "hw-b[requirements-combinator]",
        stack_size = 10,
    },
    {
        type = "recipe",
        name = "hw-requirements-combinator",
        enabled = false,
        ingredients = {
            { "copper-cable", 5 },
            { "electronic-circuit", 2 },
        },
        result = "hw-requirements-combinator",
    },
    combinator_entity("hw-status-combinator"),
    {
        type = "item",
        name = "hw-status-combinator",
        icon = "__base__/graphics/icons/signal/signal_H.png",
        icon_size = 32,
        subgroup = "homeworld",
        place_result = "hw-status-combinator",
        order = "hw-d[status-combinator]",
        stack_size = 10,
    },
    {
        type = "recipe",
        name = "hw-status-combinator",
        enabled = false,
        ingredients = {
            { "copper-cable", 5 },
            { "electronic-circuit", 2 },
        },
        result = "hw-status-combinator",
    },
    combinator_entity("hw-stockpile-combinator"),
    {
        type = "item",
        name = "hw-stockpile-combinator",
        icon = "__base__/graphics/icons/signal/signal_S.png",
        icon_size = 32,
        subgroup = "homeworld",
        place_result = "hw-stockpile-combinator",
        order = "hw-c[stockpile-combinator]",
        stack_size = 10,
    },
    {
        type = "recipe",
        name = "hw-stockpile-combinator",
        enabled = false,
        ingredients = {
            { "copper-cable", 5 },
            { "electronic-circuit", 2 },
        },
        result = "hw-stockpile-combinator",
    },
    {
        type = "item",
        name = "hw-electronics",
        icon = "__homeworld-reloaded__/graphics/icons/electronics.png",
        icon_size = 32,
        subgroup = "hw-intermediate",
        order = "hw-h[electronics]",
        stack_size = 200,
    },
    {
        type = "recipe",
        name = "hw-electronics",
        enabled = false,
        ingredients = {{"processing-unit", 1}, {"battery", 1}, {"plastic-bar", 1}},
        result = "hw-electronics",
    },
})
