dofile(core.get_modpath(core.get_current_modname()) .. "/lobby.lua")

core.override_chatcommand("pulverize", {
	privs = {creative=true},
})

core.override_chatcommand("clearinv", {
	privs = {creative=true},
})