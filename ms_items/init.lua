ms_items = {}

local files = {
    "cooldown",
    "snowball",
    "multitool",
    "basic_tools"
}

for _, file in ipairs(files) do
    dofile(core.get_modpath(core.get_current_modname()) .. "/" .. file .. ".lua")
end