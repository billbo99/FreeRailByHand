
local function item_by_hand(recipe_name, item_name, item_type)
    log(recipe_name)
    item_type = item_type or "item"
    local item = data.raw[item_type][item_name]
    local recipe = table.deepcopy(data.raw.recipe[recipe_name])

    if item then
        recipe.name = recipe.name .. "-by-hand"
        recipe.enabled = true
        recipe.ingredients = {}
        recipe.result_count = item.stack_size
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
