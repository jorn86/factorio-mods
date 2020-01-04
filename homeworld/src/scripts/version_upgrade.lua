require("scripts.utility")

return function(data)
    local upgrade = data.mod_changes['homeworld-reloaded']
    if upgrade ~= nil and upgrade.old_version:sub(1, 3) == '0.1' then
        local player_hw = global.homeworld
        global.homeworld = {player = player_hw}
        print('Homeworld upgraded from ' .. upgrade.old_version)
    end
    for k, v in pairs(global.homeworld) do
        if v == nil or v.tier == nil then
            global.homeworld[k] = {
                tier = 1,
                max_tier = 1,
                population = 1000,
                max_population = 1000,
                stockpile = {},
            }
            print('Replaced invalid homeworld state for ' .. serpent.line(global.homeworld[k]))
        end
    end
end