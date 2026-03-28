skylith = {}

skylith.DEATH_LAYER    = core.settings:get("death_layer") or -100
skylith.TIPS           = core.settings:get("tips_timer") or 900

local modpath = core.get_modpath(core.get_current_modname())

local files = {
    "callbacks",
    "clear_recipes",
    "functions",
    "inventory",
    "nodes",
    "tips",
}

for _, file in ipairs(files) do
    dofile(modpath .. "/" .. file .. ".lua")
end