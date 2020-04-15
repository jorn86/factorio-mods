local function read_barrel_size_setting()
    local size = settings.startup["bo-barrel-capacity"].value
    if size == "10" then
        return 10, 50
    end
    if size == "20" then
        return 20, 25
    end
    return 50, 10
end

local barrel_size, barrel_stack_size = read_barrel_size_setting()
local hide_barrel_recipes = settings.startup["bo-hide-barrel-recipes"].value
local empty_barrel_item = "empty-barrel"
local used_barrel_item = mods["dirtybarrels"] and "dirty-barrel" or empty_barrel_item

local blacklist = {
    "clean-barrel", "clean-barrel-fast",
    "fill-water-barrel", "fill-steam-barrel", "fill-crude-oil-barrel",
    "empty-water-barrel", "empty-sulfuric-acid-barrel"
}

local items = {}
for _, fluid in pairs(data.raw.fluid) do
    local name = fluid.name .. "-barrel"
    items[fluid.name] = name
    if data.raw.item[name] == nil then
        error("Missing barrel item " .. name)
    end
end

local function contains(table, value)
    for _, n in pairs(table) do
        if value == n then return true end
    end
    return false
end

local function gcd(a, b)
    while b > 0 do
        a, b = b, a % b
    end
    return a
end

local function lcm(a, b)
    return a * b / gcd(a, b)
end

local function least_common_multiple(numbers)
    if #numbers == 1 then
        return numbers[1]
    end
    local result = 1
    for _, n in pairs(numbers) do
        result = lcm(result, n)
    end
    return result
end

local function sum(numbers, multiplier, filter)
    local result = 0
    for _, n in pairs(numbers) do
        if filter(n) then
            result = result + (n * multiplier)
        end
    end
    return result
end

local function create_ingredient(name, amount, is_catalyst)
    return {
        type = "item",
        name = name,
        amount = amount,
        catalyst_amount = is_catalyst and amount or 0
    }
end

local function update_ingredient(ingredient)
    if type(ingredient) == "string" then
        return create_ingredient(ingredient, 1)
    end
    if ingredient.type == "fluid" then
        local new_amount = ingredient.amount / barrel_size
        return create_ingredient(items[ingredient.name], new_amount), new_amount
    end
    if ingredient.name == nil then
        return create_ingredient(ingredient[1], ingredient[2])
    end
    return ingredient
end

local function update_barrelling_recipe(recipe)
    if #recipe.ingredients == 2 and recipe.ingredients[2].name == empty_barrel_item then
        recipe.ingredients[1].amount = barrel_size
        recipe.ingredients[1].catalyst_amount = barrel_size
        return true
    elseif recipe.results ~= nil and #recipe.results == 2 and recipe.results[2].name == used_barrel_item then
        recipe.results[1].amount = barrel_size
        recipe.results[1].catalyst_amount = barrel_size
        return true
    end
    return false
end

local function find_single_multiplier(count)
    local divisor = 1
    while divisor <= 100 do
        if count * divisor % 1 == 0 then
            return divisor
        end
        divisor = divisor + 1
    end
end

local function update_single_ingredient(recipe, ingredient, barrel_counts, is_output)
    local new_ingredient, barrels = update_ingredient(ingredient)
    if barrels ~= nil then
        table.insert(barrel_counts, is_output and -barrels or barrels)
    end
    if recipe.main_product ~= nil and recipe.main_product == ingredient.name then
        recipe.main_product = new_ingredient.name
    end
    return new_ingredient
end

local function update_ingredients(recipe)
    local barrel_counts = {}
    for i, ingredient in pairs(recipe.ingredients) do
        recipe.ingredients[i] = update_single_ingredient(recipe, ingredient, barrel_counts)
    end
    if recipe.result ~= nil then
        recipe.results = { update_single_ingredient(recipe, { recipe.result, recipe.result_count or 1 }, barrel_counts, true) }
        recipe.result = nil
    else
        for i, result in pairs(recipe.results) do
            recipe.results[i] = update_single_ingredient(recipe, result, barrel_counts, true)
        end
    end
    return barrel_counts
end

local function scale_recipe(recipe, multiplier)
    recipe.energy_required = (recipe.energy_required or 1) * multiplier
    for _, ingredient in pairs(recipe.ingredients) do
        ingredient.amount = ingredient.amount * multiplier
    end
    for _, result in pairs(recipe.results) do
        result.amount = result.amount * multiplier
    end
end

local function add_barrels(recipe, add_empty, add_used)
    if add_empty > 0 then
        table.insert(recipe.ingredients, create_ingredient(empty_barrel_item, add_empty))
    end
    if add_used > 0 then
        if recipe.main_product == nil then
            recipe.main_product = recipe.results[1].name
        end
        table.insert(recipe.results, create_ingredient(used_barrel_item, add_used, true))
    end
end

local function add_empty_barrels(recipe, barrel_counts, multiplier)
    if empty_barrel_item ~= used_barrel_item then
        local add_empty = -sum(barrel_counts, multiplier, function(it) return it < 0 end)
        local add_used = sum(barrel_counts, multiplier, function(it) return it > 0 end)
        add_barrels(recipe, add_empty, add_used)
    else
        local barrel_sum = sum(barrel_counts, multiplier, function() return true end)
        add_barrels(recipe, -barrel_sum, barrel_sum)
    end
end

local function update_recipe(recipe, keep)
    if update_barrelling_recipe(recipe) then
        if not keep and hide_barrel_recipes then
            recipe.hidden = true
        end
        return
    end
    if keep then
        return
    end
    local barrel_counts = update_ingredients(recipe)
    if #barrel_counts ~= 0 then
        local multipliers = {}
        for _, count in pairs(barrel_counts) do
            local m = find_single_multiplier(math.abs(count))
            table.insert(multipliers, m)
        end
        local multiplier = least_common_multiple(multipliers)
        scale_recipe(recipe, multiplier)
        add_empty_barrels(recipe, barrel_counts, multiplier)
    end
end

for _, recipe in pairs(data.raw.recipe) do
    local blacklisted = contains(blacklist, recipe.name)
    if recipe.normal ~= nil then
        update_recipe(recipe.normal, blacklisted)
        update_recipe(recipe.expensive, blacklisted)
    else
        update_recipe(recipe, blacklisted)
    end
end

data.raw.item["empty-barrel"].stack_size = barrel_stack_size
for _, item in pairs(data.raw.item) do
    if item.subgroup == "fill-barrel" then
        item.stack_size = barrel_stack_size
    end
end
