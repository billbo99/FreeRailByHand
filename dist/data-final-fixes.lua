local function fix_results(results, name, stack_size)
    for _,item in pairs(results) do
        if item.name == name then item.amount = stack_size end
        if item[1] == name then item[2] = stack_size end
    end
    return results
end

local function item_by_hand(recipe_name, item_name, item_type)
    log(recipe_name)
    item_type = item_type or "item"
    local item = data.raw[item_type][item_name]
    local recipe = table.deepcopy(data.raw.recipe[recipe_name])

    if item then
        recipe.name = recipe.name .. "-by-hand"
        recipe.enabled = true
        if recipe.ingredients then recipe.ingredients = {} end
        if recipe.result then recipe.result_count = item.stack_size end
        if recipe.results then recipe.results = fix_results(recipe.results, item_name, item.stack_size) end

        if recipe.normal then
            recipe.normal.ingredients = {}
            recipe.normal.enabled = true
            if recipe.normal.results then recipe.normal.results = fix_results(recipe.normal.results, item_name, item.stack_size) end
            if recipe.normal.result then recipe.normal.result_count = item.stack_size end
        end
        if recipe.expensive then
            recipe.expensive.ingredients = {}
            recipe.expensive.enabled = true
            if recipe.expensive.results then recipe.expensive.results = fix_results(recipe.expensive.results, item_name, item.stack_size) end
            if recipe.expensive.result then recipe.expensive.result_count = item.stack_size end
        end

        recipe.category = "crafting-by-hand"
        data:extend({ recipe })
    else
        log("Missing item called .. " .. item_name)
    end
end

item_by_hand("rail", "rail", "rail-planner")
item_by_hand("rail-signal", "rail-signal")
item_by_hand("rail-chain-signal", "rail-chain-signal")
item_by_hand("train-stop", "train-stop")
item_by_hand("locomotive", "locomotive", "item-with-entity-data")
item_by_hand("cargo-wagon", "cargo-wagon", "item-with-entity-data")
item_by_hand("fluid-wagon", "fluid-wagon", "item-with-entity-data")

if mods["train-pubsub"] then
    item_by_hand("train-publisher", "train-publisher", "item-with-tags")
    item_by_hand("subscriber-train-stop", "subscriber-train-stop")
    item_by_hand("publisher-train-stop", "publisher-train-stop")
end
