local S = core.get_translator(core.get_current_modname())

local pieces = {
    "3d_armor:helmet_",
    "3d_armor:chestplate_",
    "3d_armor:leggings_",
    "3d_armor:boots_",
    "shields:shield_"
}

for k, _ in pairs(armor.materials) do
    for _, piece in pairs(pieces) do
        local item = piece .. k
        local def = core.registered_tools[item]
        if def then
            local new_desc = ""

            local protection = def.armor_groups.fleshy
            if protection and protection ~= 0 then
                new_desc = new_desc .. "\n" .. S("Armor Protection: @1", protection)
            end

            local healing = def.groups.armor_heal
            if healing and healing ~= 0 then
                new_desc = new_desc .. "\n" .. S("Armor Healing: @1", healing)
            end

            local feather = def.groups.armor_feather
            if feather and feather ~= 0 then
                new_desc = new_desc .. "\n" .. S("Feather Falling: @1", feather)
            end

            core.override_item(item, {description =  def.description .. core.colorize("grey", (new_desc))})
        end
    end
end