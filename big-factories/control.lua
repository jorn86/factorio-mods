require('scripts.loaders')
require('scripts.spawn')
require('scripts.utility')

script.on_event(defines.events.on_chunk_generated, trigger_spawn)

script.on_event(defines.events.on_player_mined_entity, entity_mined)
script.on_event(defines.events.on_robot_mined_entity, entity_mined)
script.on_event(defines.events.on_built_entity, entity_built)
script.on_event(defines.events.on_entity_spawned, entity_built)
script.on_event(defines.events.on_robot_built_entity, entity_built)
script.on_event(defines.events.script_raised_built, entity_built)
script.on_event(defines.events.on_player_selected_area, regenerate)
script.on_event(defines.events.on_player_alt_selected_area, remove)