return function(mods)
    local factories = {}

    if (mods["bobassembly"]) then
        table.insert(factories, {"assembling-machine", "assembling-machine-6", 1})
        table.insert(factories, {"assembling-machine", "chemical-plant-4", 0.2})
        table.insert(factories, {"assembling-machine", "electronics-machine-3", 0.1})
        table.insert(factories, {"assembling-machine", "oil-refinery-4", 0.04})
        if (mods["bobplates"]) then
            table.insert(factories, {"assembling-machine", "bob-distillery-5", 0.01})
            table.insert(factories, {"assembling-machine", "electrolyser-4", 0.2})
            table.insert(factories, {"assembling-machine", "electric-chemical-mixing-furnace-2", 0.8})
        else
            table.insert(factories, {"furnace", "electric-furnace", 0.8})
        end
    else
        table.insert(factories, {"assembling-machine", "assembling-machine-3", 1})
        table.insert(factories, {"assembling-machine", "oil-refinery", 0.04})
        table.insert(factories, {"assembling-machine", "chemical-plant", 0.2})
        --table.insert(factories, {"assembling-machine", "centrifuge", 0.01})
        table.insert(factories, {"furnace", "electric-furnace", 0.8})
        if (mods["bobplates"]) then
            table.insert(factories, {"assembling-machine", "bob-distillery", 0.01})
            table.insert(factories, {"assembling-machine", "chemical-furnace", 0.2}) -- not called electric, apparently
            table.insert(factories, {"assembling-machine", "electrolyser", 0.2})
            table.insert(factories, {"assembling-machine", "electric-mixing-furnace", 0.2})
        end
    end

    if (mods["bobtech"]) then
        table.insert(factories, {"lab", "lab-2", 0.02})
    else
        table.insert(factories, {"lab", "lab", 0.02})
    end
    if (mods["bobmodules"]) then
        table.insert(factories, {"lab", "lab-module", 0.01})
    end

    if (mods["bobgreenhouse"]) then
        table.insert(factories, {"assembling-machine", "bob-greenhouse", 0.04})
    end

    if (mods["angelsrefining"]) then
        table.insert(factories, {"assembling-machine", "ore-crusher-3", 0.2})
        table.insert(factories, {"assembling-machine", "ore-sorting-facility-4", 0.1})
        table.insert(factories, {"assembling-machine", "ore-floatation-cell-3", 0.05})
        table.insert(factories, {"assembling-machine", "ore-leaching-plant-3", 0.02})
        table.insert(factories, {"assembling-machine", "ore-refinery-2", 0.01})
        table.insert(factories, {"assembling-machine", "ore-powderizer-3", 0.01})

        table.insert(factories, {"assembling-machine", "filtration-unit-2", 0.05})
        table.insert(factories, {"assembling-machine", "crystallizer-2", 0.05})
        table.insert(factories, {"assembling-machine", "liquifier-2", 0.05})
        table.insert(factories, {"assembling-machine", "hydro-plant-3", 0.05})
    end

    if (mods["angelspetrochem"]) then
        table.insert(factories, {"assembling-machine", "advanced-chemical-plant-2", 0.05})
        table.insert(factories, {"assembling-machine", "angels-air-filter-2", 0.05})
        table.insert(factories, {"assembling-machine", "angels-chemical-plant-4", 0.05})
        table.insert(factories, {"assembling-machine", "angels-electrolyser-4", 0.05})
        table.insert(factories, {"assembling-machine", "gas-refinery-3", 0.05}) -- because the gas-refinery-4 recipe won"t be found for some reason
        table.insert(factories, {"assembling-machine", "salination-plant-2", 0.02})
        table.insert(factories, {"assembling-machine", "steam-cracker-4", 0.05})
    end

    if (mods["angelssmelting"]) then
        table.insert(factories, {"assembling-machine", "blast-furnace-4", 0.1})
        table.insert(factories, {"assembling-machine", "casting-machine-4", 0.1})
        table.insert(factories, {"assembling-machine", "angels-chemical-furnace-4", 0.1})
        table.insert(factories, {"assembling-machine", "induction-furnace-4", 0.1})
        table.insert(factories, {"assembling-machine", "ore-processing-machine-4", 0.1})
        table.insert(factories, {"assembling-machine", "pellet-press-4", 0.1})
        table.insert(factories, {"assembling-machine", "powder-mixer-4", 0.1})
        table.insert(factories, {"assembling-machine", "strand-casting-machine-4", 0.1})
        table.insert(factories, {"assembling-machine", "sintering-oven-4", 0.02})
    end

    if (mods["angelsbioprocessing"]) then
        table.insert(factories, {"assembling-machine", "algae-farm-3", 0.1})
        --table.insert(factories, {"assembling-machine", "bio-arboretum-1", 0.05})
        table.insert(factories, {"furnace", "bio-butchery", 0.01})
        table.insert(factories, {"furnace", "bio-hatchery", 0.01})
        table.insert(factories, {"assembling-machine", "bio-press", 0.05})
        table.insert(factories, {"assembling-machine", "bio-processor", 0.05})
        table.insert(factories, {"furnace", "composter", 0.05})
        table.insert(factories, {"assembling-machine", "nutrient-extractor", 0.05})

        table.insert(factories, {"assembling-machine", "bio-refugium-biter", 0})
        table.insert(factories, {"assembling-machine", "bio-refugium-fish", 0})
        --table.insert(factories, {"assembling-machine", "bio-refugium-hogger", 0})
        table.insert(factories, {"assembling-machine", "bio-refugium-puffer", 0})

        table.insert(factories, {"assembling-machine", "crop-farm", 0.01})
        table.insert(factories, {"assembling-machine", "desert-farm", 0.01})
        table.insert(factories, {"assembling-machine", "swamp-farm", 0.01})
        table.insert(factories, {"assembling-machine", "temperate-farm", 0.01})
    end

    return factories
end
