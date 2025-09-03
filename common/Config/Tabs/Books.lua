-- Books options group
-------------------------------------------------------------------------------------------------------

WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
WOWTR.Config.Groups = WOWTR.Config.Groups or {}

function WOWTR.Config.Groups.Books()
  return {
    type = "group", order = 5,
    name = function() return QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.tab5 or "Books") end,
    get = function(info) return WOWTR.db.profile.books[info[#info]] end,
    set = function(info, val) WOWTR.db.profile.books[info[#info]] = val; WOWTR.Config.SyncGlobalsFromDB() end,
    args = {
      active = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.active or "Enable"), order = 1 },
      title = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.title or "Translate title"), order = 2 },
      showID = { type = "toggle", name = "Show ID", order = 3 },
      setsize = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.setsize or "Custom size"), order = 4 },
      fontsize = { type = "range", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.fontsize or "Font size"), min = 10, max = 24, step = 1, order = 5 },
      saveNW = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.saveNW or "Save untranslated"), order = 6 },
    },
  }
end


