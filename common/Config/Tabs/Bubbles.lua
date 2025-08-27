-- Bubbles options group
-------------------------------------------------------------------------------------------------------

WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
WOWTR.Config.Groups = WOWTR.Config.Groups or {}

function WOWTR.Config.Groups.Bubbles()
  return {
    type = "group", order = 3,
    name = function() return QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.tab2 or "Bubbles") end,
    get = function(info) return WOWTR.db.profile.bubbles[info[#info]] end,
    set = function(info, val) WOWTR.db.profile.bubbles[info[#info]] = val; WOWTR.Config.SyncGlobalsFromDB() end,
    args = {
      active = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.active or "Enable"), order = 1 },
      chat_en = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.chaten or "Chat EN"), order = 2 },
      chat_tr = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.chattr or "Chat TR"), order = 3 },
      saveNB = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.saveNB or "Save untranslated bubbles"), order = 4 },
      setsize = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.setsize or "Custom size"), order = 5 },
      fontsize = { type = "range", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.fontsize or "Font size"), min = 10, max = 24, step = 1, order = 6 },
      sex = { type = "select", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.sex or "Speaker"), values = { [2] = "Male", [3] = "Female", [4] = "Character" }, order = 7 },
      dungeon = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.dungeon or "Dungeon frames"), order = 8 },
      timeDisplay = { type = "range", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.timeDisplay or "Time"), min = 1, max = 20, step = 1, order = 9 },
    },
  }
end

