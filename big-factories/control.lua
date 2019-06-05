require('scripts.loaders')
require('scripts.spawn')
require('scripts.utility')

script.on_init(spawnInit)
script.on_event(defines.events.on_chunk_generated, triggerSpawn)

script.on_event(defines.events.on_player_mined_entity, entityMined)
script.on_event(defines.events.on_robot_mined_entity, entityMined)
script.on_event(defines.events.on_built_entity, entityBuilt)
script.on_event(defines.events.on_entity_spawned, entityBuilt)
script.on_event(defines.events.on_robot_built_entity, entityBuilt)
script.on_event(defines.events.script_raised_built, entityBuilt)
