-- Description: The AddOn displays the translated text information in chosen language
-- Author: Platine [platine.wow@gmail.com]
-- Co-Author: Dragonarab[WoWAR], Hakan YILMAZ[WoWTR]
-------------------------------------------------------------------------------------------------------

-- WoW_Config.lua now loads configuration modules
-- Modules are located in the 'common/wow_config' directory

local modules = {
    "common.wow_config.check_button_state",
    "common.wow_config.dungeon_frames",
    "common.wow_config.ui_options",
    "common.wow_config.panels",
}

for _, moduleName in ipairs(modules) do
    local ok, err = pcall(require, moduleName)
    if not ok then
        error("Failed to load module '" .. moduleName .. "': " .. tostring(err))
    end
end
