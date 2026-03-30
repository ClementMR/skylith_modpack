local spawnpoint = core.settings:get_pos("static_spawnpoint")

function skylith.try_tp_to_spawn(player)
    if spawnpoint then
        player:set_pos(spawnpoint)
        return
    end

    player:respawn()
end

function skylith.reset_inventories(player)
    player:get_inventory():set_list("main", {})
    player:get_inventory():set_list("craft", {})
    armor:remove_all(player)
end

function skylith.show_minimap(player, bool)
    player:hud_set_flags({
        minimap = bool,
        minimap_radar = bool
    })
end

function skylith.reset_health(player)
    local max_hp = core.PLAYER_MAX_HP_DEFAULT or 20
    if player:get_hp() == max_hp then
        return
    end

    player:set_hp(max_hp)
end

local function kill_player()
    if core.is_singleplayer() then return end

    for _, player in ipairs(core.get_connected_players()) do
        local pos = player:get_pos()
        if player and pos.y <= skylith.DEATH_LAYER and not core.check_player_privs(player, {creative=true}) then
            player:set_hp(0)
        end
    end

    core.after(2, kill_player)
end

core.after(0.1, kill_player)