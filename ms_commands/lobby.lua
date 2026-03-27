local teleporting = {} -- Players currently teleporting

local S = core.get_translator(core.get_current_modname())

local function is_game_loading(player)
	local entry = minigame.get_player_entry(player)
	if entry then
		local game, map = minigame.get_gamedef_and_mapdef(entry.game, entry.map)
		if minigame.get_map_information(game, map).loading then
			core.chat_send_player(player:get_player_name(),
			core.colorize("#F4320B", S("You are not allowed to leave the map while it's loading!")))
			return true
		end
	end
	return false
end

core.register_chatcommand("lobby", {
	description = S("Teleport the player to the lobby"),
    params = "c",
	privs = {interact=true},
	func = function(name, param)
		local player = core.get_player_by_name(name)
		if not player then return false, "You are not online!" end

		local pos = core.settings:get_pos("static_spawnpoint")
		if not pos then return false, "Spawnpoint is not set!" end

        if param == "c" and teleporting[name] then
            hud_api.remove(player, "actionbar")
			teleporting[name]:cancel()
            teleporting[name] = nil
			return false, S("Teleportation cancelled!")
        end

		if minigame.get_player_entry(player) ~= nil and not is_game_loading(player) then
			minigame.leave_game(player)
			return true
		end

		if teleporting[name] then
            return false, core.colorize("red", S("Teleportation already in progress!"))
		end

		hud_api.show_actionbar(player, S("Teleportation in progress..."), "0x43E8DA")

		teleporting[name] = core.after(3, function()
			if not is_game_loading(player) then
				if minigame.get_player_entry(player) ~= nil then
					minigame.leave_game(player)
				else
					player:set_pos(pos)
				end
				core.sound_play("ms_commands_teleportation", {pos=player:get_pos(), gain=1.0})
			end
			hud_api.remove(player, "actionbar")
			teleporting[name] = nil
		end)
	end
})