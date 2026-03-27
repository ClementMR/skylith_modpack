skylith = {}

skylith.DEATH_LAYER    = core.settings:get("death_layer") or -100
skylith.TIPS           = core.settings:get("tips_timer") or 900

local modpath = core.get_modpath(core.get_current_modname())

local files = {
    "callbacks",
    "inv",
    "nodes",
    "tips"
}

for _, file in ipairs(files) do
    dofile(modpath .. "/" .. file .. ".lua")
end

local function update()
    if core.is_singleplayer() then return end

    for _, player in ipairs(core.get_connected_players()) do
        local pos = player:get_pos()
        if player and pos.y <= skylith.DEATH_LAYER and not core.check_player_privs(player, {creative=true}) then
            player:set_hp(0)
        end
    end

    core.after(2, update)
end

core.after(0.1, update)