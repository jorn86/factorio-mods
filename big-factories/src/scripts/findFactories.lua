return function(data)
    local factories = {}

    local function add(type, name, chance)
        local function insert(full_name)
            print('using ' .. full_name .. ' for bf-' .. name)
            table.insert(factories, {
                type = type,
                base_name = name,
                name = full_name,
                big_name = "bf-" .. name,
                chance = chance,
            })
        end

        local prototypes = data(type)
        for i = 9,0,-1 do
            if prototypes[name .. "-" .. i] then
                return insert(name .. "-" .. i)
            end
        end
        if prototypes[name] then
            return insert(name)
        end
        --print(name .. ' not found')
    end

    add("assembling-machine", "assembling-machine", 1)
    add("assembling-machine", "chemical-plant", 0.2)
    add("furnace", "electric-furnace", 0.8)
    add("assembling-machine", "oil-refinery", 0.04)
    --add("assembling-machine", "centrifuge", 0.01)
    add("assembling-machine", "electronics-machine", 0.1)
    --add("assembling-machine", "bob-distillery", 0.01)
    add("assembling-machine", "electrolyser", 0.2)
    add("assembling-machine", "chemical-furnace", 0.2) -- not called electric, apparently
    add("assembling-machine", "electric-mixing-furnace", 0.2)
    add("assembling-machine", "electric-chemical-mixing-furnace", 0.8)
    add("lab", "lab", 0.02)
    add("lab", "lab-module", 0.01)
    add("assembling-machine", "bob-greenhouse", 0.04)
    add("assembling-machine", "ore-crusher", 0.2)
    add("assembling-machine", "ore-sorting-facility", 0.1)
    add("assembling-machine", "ore-floatation-cell", 0.05)
    add("assembling-machine", "ore-leaching-plant", 0.02)
    add("assembling-machine", "ore-refinery", 0.01)
    add("assembling-machine", "ore-powderizer", 0.01)
    add("assembling-machine", "filtration-unit", 0.05)
    add("assembling-machine", "crystallizer", 0.05)
    add("assembling-machine", "liquifier", 0.05)
    add("assembling-machine", "hydro-plant", 0.05)
    add("assembling-machine", "advanced-chemical-plant", 0.05)
    add("assembling-machine", "angels-air-filter", 0.05)
    add("assembling-machine", "angels-chemical-plant", 0.05)
    add("assembling-machine", "angels-electrolyser", 0.05)
    add("assembling-machine", "gas-refinery", 0.05)
    add("assembling-machine", "salination-plant", 0.02)
    add("assembling-machine", "washing-plant", 0.02)
    add("assembling-machine", "steam-cracker", 0.05)
    add("assembling-machine", "blast-furnace", 0.1)
    add("assembling-machine", "casting-machine", 0.1)
    add("assembling-machine", "angels-chemical-furnace", 0.1)
    add("assembling-machine", "induction-furnace", 0.1)
    add("assembling-machine", "ore-processing-machine", 0.1)
    add("assembling-machine", "pellet-press", 0.1)
    add("assembling-machine", "powder-mixer", 0.1)
    add("assembling-machine", "strand-casting-machine", 0.1)
    add("assembling-machine", "sintering-oven", 0.02)
    add("assembling-machine", "algae-farm", 0.1)
    --add("assembling-machine", "bio-arboretum", 0.05)
    add("furnace", "bio-butchery", 0.01)
    add("furnace", "bio-hatchery", 0.01)
    add("assembling-machine", "bio-press", 0.05)
    add("assembling-machine", "bio-processor", 0.05)
    add("furnace", "composter", 0.05)
    add("assembling-machine", "nutrient-extractor", 0.05)
    add("assembling-machine", "bio-refugium-biter", 0)
    add("assembling-machine", "bio-refugium-fish", 0)
    add("assembling-machine", "bio-refugium-hogger", 0)
    add("assembling-machine", "bio-refugium-puffer", 0)
    add("assembling-machine", "crop-farm", 0.01)
    add("assembling-machine", "desert-farm", 0.01)
    add("assembling-machine", "swamp-farm", 0.01)
    add("assembling-machine", "temperate-farm", 0.01)

    log('big factory definitions:')
    log(serpent.block(factories))
    return factories
end
