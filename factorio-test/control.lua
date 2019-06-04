require "test-technologies"

--script.on_init(function() pcall(function() init(game.player) end) end)
script.on_event(defines.events.on_player_created,
    function(event) pcall(function() allUnlocks(game.get_player(event.player_index)) end) end)
