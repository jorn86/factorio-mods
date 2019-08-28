data.raw.technology["ftl-theory-A"].unit.ingredients = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "production-science-pack", 1 },
    { "utility-science-pack", 1 },
    { "space-science-pack", 1 },
}
data.raw.technology["ftl-theory-A"].effects = {
    { type = "unlock-recipe", recipe = "ftl-research-satellite" },
}
data.raw.technology["ftl-theory-A"].unit.count = settings.startup["improved-ftl-cost"].value

data.raw.technology["ftl-theory-B"].enabled = false
data.raw.technology["ftl-theory-C"].enabled = false
data.raw.technology["ftl-theory-D1"].enabled = false
data.raw.technology["ftl-theory-D2"].enabled = false

data.raw.technology["ftl-propulsion"].unit.count = settings.startup["improved-ftl-cost"].value
data.raw.technology["ftl-propulsion"].prerequisites = { "ftl-theory-A" }
data.raw.technology["ftl-propulsion"].unit.ingredients = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "production-science-pack", 1 },
    { "utility-science-pack", 1 },
    { "ftl-science-pack", 1 },
}
if (settings.startup["improved-ftl-space"].value) then
    table.insert(data.raw.technology["ftl-propulsion"].unit.ingredients, {"space-science-pack", 1})
end

table.insert(data.raw.lab["lab"].inputs, "ftl-science-pack")
