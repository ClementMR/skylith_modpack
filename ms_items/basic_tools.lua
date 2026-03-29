core.register_tool("ms_items:sword_shadow", {
    description = core.colorize("#373232", "Shadow Sword"),
    inventory_image = "ms_items_shadow_sword.png",
    range = 5,
    tool_capabilities = {
        full_punch_interval = 0.8,
        groupcaps = {
            snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses = 100, maxlevel = 3}
        },
        damage_groups = {fleshy = 12},
    },
    sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1, bigger_sword = 1},
})

if core.global_exists("visible_wielditem") then
	visible_wielditem.item_tweaks["groups"]["bigger_sword"] = {
		scale = 1.2
	}
end

if core.global_exists("xdecor") then
    xdecor.register_enchantable_tool("ms_items:sword_shadow", {
        enchants = { "sharp" }
    })
end