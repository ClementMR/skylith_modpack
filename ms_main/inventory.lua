local S = core.get_translator(core.get_current_modname())

local edit_skin_enabled = core.global_exists("edit_skin")

if core.get_modpath("sfinv") then
	local orig_get = sfinv.pages["sfinv:crafting"].get
	sfinv.override_page("sfinv:crafting", {
		get = function(self, player, context)
			local form = ""

			if edit_skin_enabled then
				form = form ..
				"style[btn_edit_skin;bgcolor=#67C447]" ..
				"image_button[7.2,0;1,1;mythisky_hanger.png;btn_edit_skin;;true;]" ..
				"tooltip[btn_edit_skin;"..S("Edit your skin").."]"
			end

			return orig_get(self, player, context) .. form
		end
	})

	core.register_on_player_receive_fields(function(player, _, fields)
		if fields.btn_edit_skin then
			edit_skin.show_formspec(player)
		end
	end)
end