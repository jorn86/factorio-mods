local function get_current_name()
    if not game.forces["player"].technologies["rt-upgrade-tech-1"].researched then
        return "radar"
    elseif not game.forces["player"].technologies["rt-upgrade-tech-2"].researched then
        return "rt-radar-1"
    elseif not game.forces["player"].technologies["rt-upgrade-tech-3"].researched then
        return "rt-radar-2"
    elseif not game.forces["player"].technologies["rt-upgrade-tech-4"].researched then
        return "rt-radar-3"
    elseif not game.forces["player"].technologies["rt-upgrade-tech-5"].researched then
        return "rt-radar-4"
    elseif not game.forces["player"].technologies["rt-upgrade-tech-6"].researched then
        return "rt-radar-5"
    elseif not game.forces["player"].technologies["rt-upgrade-tech-7"].researched then
        return "rt-radar-" .. game.forces["player"].technologies["rt-upgrade-tech-7"].level - 1
    else
        return "rt-radar-" .. game.forces["player"].technologies["rt-upgrade-tech-7"].level
    end
end

local function upgrade(e, name)
    if e.surface.create_entity{name = name, position = e.position, force = e.force } then
        e.destroy()
    end
end

local function on_built(event)
    local name = get_current_name()
    local entity = event.created_entity
    if entity.type == "radar" and entity.name ~= name then
        upgrade(entity, name)
    end
end

local function on_research(event)
    if not event.research or string.sub(event.research.name, 1, 15) == "rt-upgrade-tech" then
        local name = get_current_name()
        for _, surface in pairs(game.surfaces) do
            for _, radar in pairs(surface.find_entities_filtered{type="radar"}) do
                upgrade(radar, name)
            end
        end
    end
end

script.on_event(defines.events.on_built_entity, on_built)
script.on_event(defines.events.on_robot_built_entity, on_built)
script.on_event(defines.events.on_research_finished, on_research)
script.on_event(defines.events.on_technology_effects_reset, on_research)
