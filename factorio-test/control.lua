require "defines"
require "test-materials"
require "test-technologies"

local function init(player)
    allInserts(player)
    allUnlocks(player)
end

--script.on_init(function() pcall(function() init(game.player) end) end)
script.on_event(defines.events.on_player_created,
    function(event) pcall(function() init(game.get_player(event.player_index)) end) end)
